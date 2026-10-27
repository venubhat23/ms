# Customer Wallet — Mobile API

Covers the two places the mobile app touches a customer's wallet:

1. `GET /api/v1/mobile/customer/wallet` — balance + transaction history
2. `POST /api/v1/mobile/ecommerce/bookings` — optional `use_wallet` flag to pay for a booking out of wallet balance

Base URL prefix: `/api/v1/mobile`

All endpoints below require authentication.

## Authentication

```
Authorization: Bearer <jwt_token>
```

Obtained from `POST /auth/login` or `POST /auth/otp/verify`. Token must decode to `role: "customer"`.

| Condition | Status | Body |
|---|---|---|
| Missing header | 401 | `{ "success": false, "message": "Authorization token is required" }` |
| Invalid/expired token | 401 | `{ "success": false, "message": "Invalid or expired token" }` |
| Token valid, no matching customer | 401 | `{ "success": false, "message": "Customer account not found" }` |

## Feature flag

Both endpoints below are gated by `SystemSetting.customer_wallet_enabled?` (Admin → Settings → System). When disabled:

- `GET customer/wallet` → `403 Forbidden`, `{ "success": false, "message": "Customer wallet feature is currently disabled" }`
- `POST ecommerce/bookings` with `use_wallet: true` → booking still succeeds normally, but no wallet deduction happens; response includes `wallet_note: "Customer wallet feature is currently disabled."`

---

## GET /customer/wallet

Returns the customer's current balance and a paginated transaction history. A wallet is lazily created (balance `0`) on first call if the customer doesn't have one yet.

### Query params

| Param | Type | Default | Notes |
|---|---|---|---|
| `page` | integer | `1` | |
| `per_page` | integer | `20` | Capped at `50` |

### Response `200`

```json
{
  "success": true,
  "data": {
    "balance": 450.0,
    "formatted_balance": "₹450.0",
    "status": true,
    "history": [
      {
        "id": 812,
        "transaction_type": "debit",
        "amount": 200.0,
        "formatted_amount": "₹200.0",
        "balance_after": 450.0,
        "description": "Payment for Booking #BK20260823A1B2C3",
        "reference_number": "TXN17561234565678",
        "booking_id": 4521,
        "booking_number": "BK20260823A1B2C3",
        "created_at": "2026-08-23T10:15:22+05:30"
      }
    ],
    "pagination": {
      "current_page": 1,
      "per_page": 20,
      "total_count": 37,
      "total_pages": 2,
      "has_next_page": true,
      "has_prev_page": false
    }
  }
}
```

`transaction_type` is `"credit"` (money added — e.g. refund/rejection) or `"debit"` (money spent — e.g. booking payment). `booking_id`/`booking_number` are `null` when the transaction isn't tied to a booking.

### Response `403` — feature disabled

```json
{ "success": false, "message": "Customer wallet feature is currently disabled" }
```

---

## POST /ecommerce/bookings — paying with wallet

Wallet payment is opt-in via `use_wallet` on the existing booking-creation endpoint (not a separate endpoint). Full/partial deduction happens automatically: whichever is smaller of the wallet balance or the booking total is deducted, and any remainder is left for another payment method.

### Relevant request field

| Field | Type | Required | Notes |
|---|---|---|---|
| `booking[use_wallet]` | boolean | No | If `true` and the feature is enabled, deduct up to the full booking total from the customer's wallet before falling back to the chosen `payment_method` for the remainder. |

### Behavior

- `deduction = min(wallet.balance, booking.total_amount)`, rounded to 2 decimals.
- If `deduction == booking.total_amount` (fully covered): `payment_status = "paid"`, `payment_method = "wallet"`.
- If `deduction` is partial (> 0 but < total): `payment_status = "partially_paid"`, original `payment_method` kept for the remainder.
- If wallet balance is `0`: nothing is deducted; `wallet_note: "Wallet balance is 0 — booking was not paid from wallet."`
- If the feature is disabled: nothing is deducted; `wallet_note: "Customer wallet feature is currently disabled."`
- The wallet debit and the booking are created atomically (same DB transaction) and cross-linked: the `WalletTransaction` gets `booking_id`, and the `Booking` gets `wallet_transaction_id`.

### Relevant response fields (inside `data`)

```json
{
  "success": true,
  "data": {
    "id": 4521,
    "booking_number": "BK20260823A1B2C3",
    "payment_status": "paid",
    "payment_method": "wallet",
    "total_amount": 200.0,
    "wallet_amount_used": 200.0,
    "paid_via_wallet": true,
    "wallet_transaction_id": 812,
    "wallet_note": null,
    "...": "other standard booking fields (items, customer, delivery, etc.)"
  }
}
```

| Field | Type | Notes |
|---|---|---|
| `wallet_amount_used` | float | Amount actually deducted from wallet (`0` if none) |
| `paid_via_wallet` | boolean | `true` only when the wallet fully covered the booking |
| `wallet_transaction_id` | integer\|null | Links to the `WalletTransaction` record, also visible via `GET /customer/wallet` history |
| `wallet_note` | string\|null | Present only when `use_wallet: true` was requested but nothing was deducted (feature disabled or zero balance) |

---

## Notes for client implementation

- Always read `wallet_amount_used` + `payment_status` from the booking response to know how much (if anything) still needs to be collected via another payment method — don't assume `use_wallet: true` means fully paid.
- Show `wallet_note` to the user when present so they understand why wallet wasn't applied.
- Refresh `GET /customer/wallet` after a booking to reflect the new balance; the response doesn't push a live balance update elsewhere.
