# Mobile API — Complete Reference

End-to-end reference for every endpoint under `/api/v1/mobile`, generated from the current
controller code (`app/controllers/api/v1/mobile/*.rb`) and `config/routes.rb`. Wallet
endpoints for customers live in a companion doc: [Customer Wallet API](./CUSTOMER_WALLET_API.md).

## Contents

1. [Authentication](#authentication)
2. [E-commerce — Catalog, Search & Delivery Validation](#e-commerce--catalog-search--delivery-validation)
3. [E-commerce — Bookings, Checkout, Orders & Subscriptions](#e-commerce--bookings-checkout-orders--subscriptions)
4. [Customer Portfolio](#customer-portfolio)
5. [Settings](#settings)
6. [Banners](#banners)
7. [Delivery Person](#delivery-person)
8. [Agent Dashboard, Leads & Commission](#agent-dashboard-leads--commission)
9. [Customer Wallet](./CUSTOMER_WALLET_API.md) — separate doc
10. [Known Issues Found While Documenting This API](#known-issues-found-while-documenting-this-api)

## Conventions

- **Base URL prefix**: `/api/v1/mobile` for every endpoint below except Agent module routes,
  which nest one level deeper at `/api/v1/mobile/agent`.
- **Auth header**: `Authorization: Bearer <jwt_token>`, issued by `POST /auth/login` or
  `POST /auth/otp/verify`. The JWT payload carries `user_id` and `role`; which `role` values
  a given endpoint accepts varies by controller — see each section, and note the delivery-person
  module doesn't use the shared `role`-based guard at all (flagged below).
- **Response envelope**: most endpoints return `{ "success": bool, "data": {...} }` (GET-style)
  or `{ "success": bool, "message": "...", "data": {...} }` (mutations) — but the Agent module's
  `add_customer`/`add_lead` use `{ "status", "message", "data" }` instead. Don't assume a single
  envelope shape client-side; check each endpoint's documented response.
- Every endpoint below was documented by reading its actual controller code (not inferred from
  routes alone) — request params, response fields, and error paths reflect what the code does today.

---

## Authentication

Covers account creation, login, password recovery, and mobile-OTP login for the mobile app.

Base URL prefix: `/api/v1/mobile`

None of the endpoints below require an `Authorization` header — they are all pre-login (`authorize_request` is skipped for the whole controller on these actions). A successful `login`, `register` (customer path only implicitly — see note), or `otp/verify` call is how a client *obtains* the JWT used by every other authenticated mobile endpoint.

### JWT payload

`login` and `otp/verify` issue a JWT (`JWT.encode(payload, Rails.application.secret_key_base)`, no explicit algorithm override) with:

| Field | Notes |
|---|---|
| `user_id` | ID of the underlying record — a `User` id for customer/agent/admin logins, a `DeliveryPerson` id for delivery-person logins, a `SubAgent` id for direct sub-agent logins |
| `role` | One of `customer`, `agent`, `admin`, `sub_agent`, `delivery_person` (see per-branch table under `POST /auth/login`) |
| `exp` | 30 days from issue, as a Unix timestamp |
| `customer_id` | Only present when `role == 'customer'` |
| `delivery_person_id` | Only present when `role == 'delivery_person'` |
| `sub_agent_id` | Only present when `role == 'sub_agent'` |

Token expiry: **30 days**, fixed, no refresh-token mechanism — the client must re-login once expired.

**Downstream gotcha for other modules:** other mobile controllers gate access with `Api::V1::Mobile::BaseController#authenticate_customer!`, which only branches on `role` values `customer`, `agent`, and `sub_agent` — any other role (including `admin` and `delivery_person`, both of which `login` can legitimately issue) falls into that method's `else` and is rejected with `401 { success: false, message: 'Invalid user role' }`. Admin and delivery-person tokens are therefore only usable against endpoints that don't rely on `authenticate_customer!`.

---

### POST /auth/login

Single endpoint that tries, in order: `User` (customer / agent / admin / sub_agent-as-User), direct `Customer`, `DeliveryPerson`, then direct `SubAgent`. The response shape differs by which account type matched.

### Request body

| Field | Type | Required | Notes |
|---|---|---|---|
| `username` | string | One of `username`/`email`/`mobile` | Checked first |
| `email` | string | — | Fallback if `username` absent |
| `mobile` | string | — | Fallback if both above absent; accepts raw 10-digit, `91XXXXXXXXXX`, or `+91XXXXXXXXXX` and is normalized internally |
| `password` | string | Yes | Not required/checked for the direct **sub-agent** match (see note below) |

### Response `200` — customer (via `User`)

```json
{
  "success": true,
  "data": {
    "token": "<jwt>",
    "username": "Asha Rao",
    "role": "customer",
    "user_id": 101,
    "customer_id": 55,
    "email": "asha@example.com",
    "mobile": "9876543210",
    "customer_wallet_enabled": true,
    "portfolio_summary": {
      "total_policies": 0,
      "upcoming_installments": 0,
      "renewal_policies": 0
    }
  }
}
```

### Response `200` — agent / admin / sub_agent (via `User`)

```json
{
  "success": true,
  "data": {
    "token": "<jwt>",
    "username": "Ravi Kumar",
    "role": "agent",
    "user_id": 42,
    "email": "ravi@example.com",
    "mobile": "9876500000",
    "commission_earned": 48250.0,
    "customers_count": 12,
    "policies_count": 18,
    "commission_breakdown": {},
    "dashboard_stats": {
      "total_commission": 48250.0,
      "monthly_target": 75000,
      "achievement_percentage": 64.33,
      "policies_this_month": 5,
      "customers_this_month": 3,
      "conversion_rate": "78%"
    }
  }
}
```

`role` here is `user.user_type` (`agent`, `admin`, or `sub_agent` — a `User`-table sub-agent, distinct from the `SubAgent` table branch below). `commission_earned`/`policies_count`/`customers_count` and `conversion_rate` are **mock/generated values** (see Implementation notes), not real commission data.

### Response `200` — direct `Customer` match

Same envelope as the customer branch above, plus a `profile` block (`first_name`, `last_name`, `middle_name`, `gender`, `birth_date`, `address`, `city`, `state`, `pincode`); no `user_id`/`customer_id` distinction — both are the `Customer` id.

### Response `200` — `DeliveryPerson`

```json
{
  "success": true,
  "data": {
    "token": "<jwt>",
    "username": "Suresh Naik",
    "role": "delivery_person",
    "user_id": 7,
    "delivery_person_id": 7,
    "email": "suresh@example.com",
    "mobile": "9123456780",
    "profile": {
      "first_name": "Suresh",
      "last_name": "Naik",
      "vehicle_type": "bike",
      "vehicle_number": "KA01AB1234",
      "license_number": "DL123456",
      "delivery_areas": ["Zone 1", "Zone 2"],
      "joining_date": "2024-01-10",
      "years_of_service": 2
    },
    "dashboard_stats": {
      "total_deliveries": 168,
      "completed_deliveries": 142,
      "pending_deliveries": 26,
      "success_rate": 84.52,
      "earnings_this_month": 1400,
      "deliveries_this_month": 28,
      "average_rating": 4.6,
      "vehicle_info": "..."
    }
  }
}
```

### Response `200` — direct `SubAgent`

```json
{
  "success": true,
  "data": {
    "token": "<jwt>",
    "username": "Meena Iyer",
    "role": "sub_agent",
    "user_id": 9,
    "email": "meena@example.com",
    "mobile": "9988776655",
    "commission_earned": 32000.0,
    "customers_count": 8,
    "policies_count": 10,
    "commission_breakdown": { "life_commission": 20000.0, "motor_commission": 12000.0 },
    "monthly_target": 50000.0,
    "achievement_percentage": 64.0,
    "dashboard_stats": {
      "total_commission": 32000.0,
      "monthly_target": 50000.0,
      "achievement_percentage": 64.0,
      "policies_this_month": 2,
      "customers_this_month": 1,
      "conversion_rate": "50%",
      "ranking": 3,
      "team_size": 8,
      "performance_grade": "B"
    },
    "agency_info": {
      "agency_name": "Meena Iyer Agency",
      "license_number": "AGY000009",
      "territory": "North Zone",
      "join_date": "2025-11-02"
    }
  }
}
```

Commission figures here are computed from real `LifeInsurance`/`MotorInsurance` records (via `sub_agent_id`), unlike the `User`-agent branch above.

### Errors

| Condition | Status | Body |
|---|---|---|
| Missing login field or password | 422 | `{ "success": false, "message": "Email/Mobile and password are required" }` |
| No match found in any of the four account tables, or password/status check failed | 401 | `{ "success": false, "message": "Invalid username or password" }` |

### Implementation notes

- **Sub-agent branch bypasses password entirely** — the direct-`SubAgent` match only checks `sub_agent.status == 'active'` (the code comment says "we also don't have password in current model"). Any caller who knows/guesses a sub-agent's email or mobile can obtain a valid token for them without a password, provided no earlier branch (`User`, `Customer`, `DeliveryPerson`) matched first.
- Agent/admin `commission_earned`, `policies_count`, `customers_count`, `dashboard_stats.conversion_rate`, etc. in the **`User`-based agent branch** are deterministic mock data derived from the user's id (`generate_mock_commission`, `generate_mock_policies_count`) — a code comment notes this is because the insurance policy types that would back real commission data were removed. Do not treat these as real figures.
- `customer_wallet_enabled` is included so the client can decide whether to show wallet UI without an extra round trip.
- No login attempt rate-limiting/lockout is implemented on this endpoint (unlike `otp/request`/`otp/verify`).

---

### POST /auth/register

Dispatches on `role` (or legacy `user_type`) param to one of two sub-flows. Does **not** return a JWT — the client must call `POST /auth/login` afterward.

### Request body

| Field | Type | Required | Notes |
|---|---|---|---|
| `role` (or `user_type`) | string | No | `customer` / `user` → customer flow (default if omitted); `agent` / `sub_agent` → agent flow. Any other value → error |

#### Customer flow (`role: customer`/`user`, default)

| Field | Type | Required | Notes |
|---|---|---|---|
| `first_name` | string | Yes | Alphabetic + spaces, 2–50 chars |
| `last_name` | string | Yes | Same rule |
| `middle_name` | string | No | |
| `email` | string | Yes | Standard email format |
| `mobile` | string | Yes | Indian 10-digit, starts 6–9 (also accepts `91`/`+91`-prefixed and is normalized) |
| `password` | string | Yes | Min 6 chars |
| `password_confirmation` | string | No | Must equal `password` if given |
| `address`, `city`, `state`, `pincode` | string | No | |
| `whatsapp_number` | string | No | |
| `latitude`, `longitude` | numeric | No | |
| `is_registered_by_mobile` | — | No | Accepted but always forced to `true` internally regardless of value sent |

#### Agent flow (`role: agent`/`sub_agent`)

| Field | Type | Required | Notes |
|---|---|---|---|
| `first_name`, `last_name`, `email`, `mobile`, `password` | — | Yes | Same validation rules as customer flow |
| `password_confirmation` | string | No | Must equal `password` if given |
| `pan_no` | string | No | Stored as `pan_number` |
| `address`, `city`, `state`, `gender`, `occupation`, `annual_income` | — | No | |

### Response `200` — customer registered

```json
{
  "success": true,
  "message": "Customer registration successful. You can now login with your credentials.",
  "data": {
    "customer_id": 201,
    "user_id": 310,
    "email": "new.customer@example.com",
    "mobile": "9876543210",
    "role": "customer"
  }
}
```

A `Customer` row and a `User` row (`user_type: 'customer'`) are created together in one DB transaction so both the web `Customer` login and the mobile Devise `User` login work with the same credentials.

### Response `200` — agent registered

```json
{
  "success": true,
  "message": "Agent registration successful. Your account is pending approval by admin.",
  "data": {
    "user_id": 311,
    "email": "new.agent@example.com",
    "mobile": "9876500001",
    "role": "agent"
  }
}
```

Only a `User` row is created, with `status: false` (pending) — the agent **cannot log in via `POST /auth/login`** until an admin flips `status` to true (login requires `user.status` truthy). `role` in the response is hard-coded to `"agent"` even if the request sent `role: "sub_agent"` — no `SubAgent` record is created by this endpoint under either value; `user.user_type`/`role` column are always set to `agent`/`agent_role`.

### Errors

| Condition | Status | Body |
|---|---|---|
| `role`/`user_type` not one of the recognized values | 422 | `{ "success": false, "message": "Invalid role. Only customer and agent registration are allowed.", "valid_roles": ["customer", "agent"] }` |
| Missing required field (either flow) | 422 | `{ "success": false, "message": "First name, last name, email, mobile number, and password are required" }` |
| `password` != `password_confirmation` (when confirmation given) | 422 | `{ "success": false, "message": "Password confirmation does not match" }` |
| Invalid email format | 422 | `{ "success": false, "message": "Please enter a valid email address" }` |
| Invalid mobile format | 422 | `{ "success": false, "message": "Please enter a valid Indian mobile number (10 digits starting with 6-9)" }` |
| `first_name`/`last_name` fails alpha-only/length check | 422 | `{ "success": false, "message": "First name should contain only alphabetic characters and be 2-50 characters long" }` (or the "Last name..." equivalent) |
| `password` shorter than 6 chars | 422 | `{ "success": false, "message": "Password must be at least 6 characters long" }` |
| Email already used (customer flow: checked against both `Customer` and `User`; agent flow: `User` only) | 409 | `{ "success": false, "message": "An account with this email address already exists. Please use a different email or try logging in." }` |
| Mobile already used | 409 | `{ "success": false, "message": "An account with this mobile number already exists. Please use a different mobile number or try logging in." }` |
| Customer-flow: `ActiveRecord::RecordInvalid` inside the transaction | 422 | `{ "success": false, "message": "Customer registration failed", "errors": ["..."] }` |
| Customer-flow: unexpected error | 500 | `{ "success": false, "message": "Registration failed due to system error", "error": "<exception message>" }` |
| Agent-flow: `user.save` validation failure | 422 | `{ "success": false, "message": "Agent registration failed", "errors": ["..."] }` |

---

### POST /auth/forgot_password

Sends a password-reset email to a `Customer` account. Always resolves email lookup case-insensitively.

### Request body

| Field | Type | Required | Notes |
|---|---|---|---|
| `email` | string | Yes | Matched case-insensitively against `Customer.email` |

### Response `200`

```json
{ "success": true, "message": "Password reset instructions have been sent to your email" }
```

Returned even if the mailer itself raises — the send failure is only logged server-side (`Rails.logger.error`), not surfaced to the client. A reset token is generated and persisted either way.

### Errors

| Condition | Status | Body |
|---|---|---|
| `email` blank | 422 | `{ "success": false, "message": "Email is required" }` |
| No `Customer` with that email | 404 | `{ "success": false, "message": "No account found with that email address" }` |

### Implementation notes

- Reset token is a 32-byte hex string, valid for **24 hours** from generation (`password_reset_sent_at < 24.hours.ago` → expired).
- This endpoint only checks/emails `Customer` accounts — a `User`-only agent/admin/delivery-person/sub_agent has no equivalent flow here.

---

### POST /auth/reset_password

### Request body

| Field | Type | Required | Notes |
|---|---|---|---|
| `token` | string | Yes | From the reset email link |
| `password` | string | Yes | Min 6 chars |
| `password_confirmation` | string | Yes (effectively) | Must equal `password` |

### Response `200`

```json
{ "success": true, "message": "Password has been reset successfully. You can now log in." }
```

### Errors

| Condition | Status | Body |
|---|---|---|
| `token` blank | 422 | `{ "success": false, "message": "Reset token is required" }` |
| Token not found, or older than 24h (query itself filters by 24h window) | 422 | `{ "success": false, "message": "Invalid or expired reset token" }` |
| Token found but expired (redundant secondary check — see note) | 422 | `{ "success": false, "message": "Reset token has expired. Please request a new one." }` |
| `password` blank or < 6 chars | 422 | `{ "success": false, "message": "Password must be at least 6 characters" }` |
| `password` != `password_confirmation` | 422 | `{ "success": false, "message": "Password confirmation does not match" }` |
| `customer.save` fails validation | 422 | `{ "success": false, "message": "Failed to update password", "errors": ["..."] }` |

### Implementation notes

- On success: the token is cleared, the paired `User` record's password is synced (best-effort — a sync failure is only logged, not returned as an error), and a "password changed" notification email is sent (also best-effort).
- The dedicated "token expired" branch is effectively unreachable in normal operation: `Customer.find_by_password_reset_token` already scopes to `password_reset_sent_at > 24.hours.ago`, so a token that fails that check returns `nil` and hits the "Invalid or expired reset token" branch above it instead.

---

### POST /auth/otp/request

Sends a 6-digit OTP by SMS (via MSG91) for mobile login/signup. Gated by `SystemSetting.otp_login_enabled?`.

### Request body

| Field | Type | Required | Notes |
|---|---|---|---|
| `mobile` | string | Yes | Indian 10-digit, starts 6–9 (also accepts `91`/`+91`-prefixed) |

### Response `200`

```json
{ "success": true, "message": "OTP sent successfully", "retry_after": 60 }
```

`retry_after` is the resend cooldown in seconds (fixed at 60).

### Errors

| Condition | Status | Body |
|---|---|---|
| OTP login disabled (`SystemSetting.otp_login_enabled?` false) | 403 | `{ "success": false, "message": "OTP login is currently disabled" }` |
| Invalid mobile format | 422 | `{ "success": false, "message": "Please enter a valid Indian mobile number (10 digits starting with 6-9)" }` |
| Requested again within 60s of the last request for this mobile | 429 | `{ "success": false, "message": "Please wait before requesting another OTP", "retry_after": <seconds_remaining> }` |
| More than 5 requests for this mobile within the last hour | 429 | `{ "success": false, "message": "Too many OTP requests. Please try again later.", "retry_after": 3600 }` |
| SMS provider send failure | 500 | `{ "success": false, "message": "Failed to send OTP" }` (or provider-specific error text) |

### Implementation notes

- OTP is 6 digits, valid **5 minutes**, max **5 verify attempts** before lockout.
- Generating a new OTP invalidates any still-active OTP previously issued for the same mobile+purpose (`login`) — only the latest code can verify.
- In non-production environments without MSG91 credentials configured, the OTP is logged server-side instead of actually sent (`dev_fallback: true` internally, not exposed in the response) — useful for testing but means SMS delivery isn't guaranteed configured even where this endpoint returns success.
- In production without MSG91 credentials configured, this endpoint fails closed with the 500 above rather than silently logging.

---

### POST /auth/otp/verify

Verifies an OTP and logs the customer in, creating a minimal `User`+`Customer` pair on first-ever login for that mobile number.

### Request body

| Field | Type | Required | Notes |
|---|---|---|---|
| `mobile` | string | Yes | Same normalization as `otp/request` |
| `otp` | string | Yes | The 6-digit code |

### Response `200`

```json
{
  "success": true,
  "message": "Logged in successfully",
  "data": {
    "token": "<jwt>",
    "user_id": 405,
    "customer_id": 88,
    "mobile": "9876543210",
    "is_new_user": false,
    "customer_wallet_enabled": true
  }
}
```

`message` is `"Account created and logged in successfully"` when `is_new_user: true`. Issued `token` always has `role: "customer"`.

### Errors

| Condition | Status | Body |
|---|---|---|
| OTP login disabled | 403 | `{ "success": false, "message": "OTP login is currently disabled" }` |
| Invalid mobile format, or `otp` blank | 422 | `{ "success": false, "message": "Mobile number and OTP are required" }` |
| No active OTP found for this mobile, or code doesn't match (and under attempt limit) | 422 | `{ "success": false, "message": "Invalid OTP" }` |
| Latest OTP for this mobile is past its 5-minute TTL | 422 | `{ "success": false, "message": "OTP has expired. Please request a new one." }` |
| 5th incorrect attempt reached (on this attempt or a prior one) | 429 | `{ "success": false, "message": "Too many incorrect attempts. Please request a new OTP." }` |

### Implementation notes

- **First-time OTP login** (no existing `User` with that mobile) creates both a `User` and a `Customer` record with placeholder data: `first_name: "Customer"`, `last_name` = last 4 digits of the mobile number, a synthetic unique email `otp_<mobile>@users.noemail`, and a random 32-char password neither party knows. The client should prompt the user to complete their profile afterward (e.g. via `PUT /settings/profile`).
- If a `User` already exists for the mobile but no paired `Customer` does, one is created on the fly (mirrors the `register_customer` pairing logic) rather than erroring.
- A correct OTP is single-use — verifying sets `verified_at`, and the `active` scope used to look up the current OTP excludes already-verified rows, so replaying the same OTP after a successful verify falls through to "Invalid OTP" (no active record left) rather than a distinct "already used" error.
## E-commerce — Catalog, Search & Delivery Validation

Covers product/category browsing, search, filters, banners, delivery/pincode checks, location saving, and the customer profile — everything in `Api::V1::Mobile::EcommerceController` except bookings/checkout/orders/subscriptions (covered separately).

Base URL prefix: `/api/v1/mobile`

### Authentication

```
Authorization: Bearer <jwt_token>
```

The controller applies `before_action :authenticate_customer!, except: [:products, :banners, :featured_products]`. That means **only three endpoints below are public** — `GET ecommerce/products`, `GET ecommerce/banners`, and `GET ecommerce/featured_products`. Every other endpoint in this section (including plain category/product-detail browsing, search, and filters) requires a valid customer bearer token, which may be a client integration gotcha if the mobile app expects catalog browsing to be public.

| Condition | Status | Body |
|---|---|---|
| Missing header | 401 | `{ "success": false, "message": "Authorization token is required" }` |
| Malformed/invalid token | 401 | `{ "success": false, "message": "Invalid authorization token" }` |
| Token role not `customer`/`agent`/`sub_agent` | 401 | `{ "success": false, "message": "Invalid user role" }` |
| Token valid, no matching `Customer` record | 401 | `{ "success": false, "message": "Customer account not found" }` |

### Two independent delivery-checking systems

The controller has two unrelated ways to answer "can this be delivered here," and endpoints below use one or the other — worth knowing before wiring up the client:

- **Product-level `DeliveryRule`** (per product, admin-configured "everywhere" or specific-pincode rules): used by `POST products/:id/check_delivery` and the per-product loop inside `POST delivery/validate`. Returns `delivery_days` / `delivery_charge` from the matching rule (defaults `7` days / `0` charge if a rule matches but doesn't specify).
- **Global `DeliveryCharge`** (one row per serviceable pincode, admin-configured, not tied to any product): used by `POST check_delivery` (by pincode only) and `POST delivery/charges`. Returns `area` / `charge_amount` for the pincode, independent of what's being ordered.

Separately, `GET delivery/check-pincode/:pincode` and `POST delivery/validate` also call a third mechanism — `validate_pincode`, which hits the external `api.postalpincode.in` service (with a Rails cache) to resolve district/state/serviceability, unrelated to both of the above.

---

### GET /ecommerce/categories

Auth required. Returns all active categories, cached (`MobileApiCache::CATEGORY_TTL`).

### Response `200`

```json
{
  "success": true,
  "data": [
    {
      "id": 3,
      "name": "Dairy",
      "description": "Milk and dairy products",
      "image_url": "https://.../dairy.jpg",
      "products_count": 24,
      "display_order": 1
    }
  ],
  "message": "Categories retrieved successfully"
}
```

`image_url` is `null` if the category has no attached image. `products_count` here comes from `category.products.size` (all associated products, not filtered by active/available-for-sale).

---

### GET /ecommerce/categories/:id

Auth required.

### Response `200`

```json
{
  "success": true,
  "data": {
    "id": 3,
    "name": "Dairy",
    "description": "Milk and dairy products",
    "image_url": "https://.../dairy.jpg",
    "products_count": 24,
    "display_order": 1
  },
  "message": "Category details retrieved successfully"
}
```

### Response `404`

```json
{ "success": false, "message": "Category not found" }
```

---

### GET /ecommerce/categories/:id/products

Auth required. Paginated product listing scoped to one category.

### Query params

| Param | Type | Default | Notes |
|---|---|---|---|
| `page` | integer | `1` | |
| `per_page` | integer | `20` | Capped at `50` |
| `min_price` | number | — | |
| `max_price` | number | — | |
| `search` | string | — | Uses `Product.search` |
| `sort_by` | string | `name` (asc) | `price_low`, `price_high`, `name`, `newest`, `rating`; anything else falls back to `order(:name)` |

Only `Product.active.available_for_sale` rows in the given category are included.

### Response `200`

```json
{
  "success": true,
  "data": {
    "products": [ { "...": "see format_product_data below" } ],
    "pagination": {
      "current_page": 1,
      "per_page": 20,
      "total_count": 24,
      "total_pages": 2,
      "has_next_page": true,
      "has_prev_page": false
    },
    "category": { "id": 3, "name": "Dairy" },
    "applied_filters": {
      "min_price": null,
      "max_price": null,
      "search": null,
      "sort_by": null
    }
  },
  "message": "Category products retrieved successfully"
}
```

### Response `404`

```json
{ "success": false, "message": "Category not found" }
```

---

### GET /ecommerce/products

**Public — no auth required.** Paginated, filterable product listing.

### Query params

| Param | Type | Default | Notes |
|---|---|---|---|
| `page` | integer | `1` | |
| `per_page` | integer | `20` | Capped at `50` |
| `category_id` | integer | — | |
| `min_price` | number | — | |
| `max_price` | number | — | |
| `search` | string | — | Uses `Product.search` |
| `sort_by` | string | stock availability | `price_low`, `price_high`, `name`, `newest`, `rating`; default (unrecognized/blank) is `by_stock_availability` |

Scope is always `Product.active.available_for_sale`. Result (including the product list itself) is cached per unique combination of these params (`MobileApiCache::PRODUCT_TTL`).

### Response `200`

```json
{
  "success": true,
  "data": {
    "products": [ { "...": "see format_product_data below" } ],
    "pagination": {
      "current_page": 1,
      "per_page": 20,
      "total_count": 132,
      "total_pages": 7,
      "has_next_page": true,
      "has_prev_page": false
    },
    "applied_filters": {
      "category_id": null,
      "min_price": null,
      "max_price": null,
      "search": null,
      "sort_by": null
    }
  },
  "message": "Products retrieved successfully"
}
```

### `format_product_data` shape (used by `products`, `category_products`, `search`, `featured_products`, and embedded in `product_details`)

```json
{
  "id": 501,
  "name": "Full Cream Milk 1L",
  "description": "Farm-fresh full cream milk",
  "price": 60.0,
  "discount_price": 55.0,
  "selling_price": 55.0,
  "final_price": 55.0,
  "discount_percentage": 8,
  "discount_type": "flat",
  "discount_value": 5.0,
  "original_price": 60.0,
  "savings_amount": 5.0,
  "stock": 120,
  "sku": "MLK-1L-001",
  "unit": "ltr",
  "weight": 1.0,
  "dimensions": null,
  "product_type": "grocery",
  "barcode": null,
  "hsn_code": "0401",
  "tags": ["dairy", "milk"],
  "display_order": 1,
  "is_subscription_enabled": true,
  "is_occasional_product": false,
  "gst_enabled": true,
  "gst_percentage": 5.0,
  "category": { "id": 3, "name": "Dairy" },
  "image": "https://.../milk.jpg",
  "images": ["https://.../milk.jpg", "https://.../milk2.jpg"],
  "rating": { "average": 4.5, "count": 12 },
  "is_in_stock": true,
  "is_discounted": true,
  "is_low_stock": false,
  "stock_status": "in_stock",
  "created_at": "2026-08-01T10:00:00+05:30",
  "updated_at": "2026-08-20T09:00:00+05:30",
  "has_multiple_quantities": false,
  "display_price": 55.0,
  "default_variant_id": null,
  "variants": []
}
```

When `has_multiple_quantities` is `true`, `variants` is populated (one entry per `ProductVariant`, sorted by weight) with `id`, `label`, `weight`, `unit`, `buying_price`, `selling_price`, `discount_enabled`, `discount_type`, `discount_value`, `discount_amount`, `effective_price`, `gst_percentage`, `gst_amount`, `price_after_discount`, `available_stock`, `is_default`, `is_in_stock` — and `display_price`/`default_variant_id` reflect the default (or cheapest) variant rather than the base product price.

---

### GET /ecommerce/products/:id

Auth required. Cached per product id (`MobileApiCache::PRODUCT_TTL`). Scope is `Product.active`.

### Response `200`

Returns the standard `format_product_data` object (above) merged with:

```json
{
  "related_products": [ { "...": "up to 5 in-stock products from the same category, format_product_data shape" } ],
  "reviews": [
    {
      "id": 91,
      "rating": 5,
      "comment": "Great quality",
      "reviewer_name": "Asha K",
      "verified_purchase": true,
      "helpful_count": 3,
      "created_at": "2026-08-10T12:00:00+05:30"
    }
  ],
  "delivery_info": {
    "available_locations": ["All India"],
    "estimated_delivery": "3-5 business days",
    "shipping_charges": "Free shipping above ₹500"
  }
}
```

`reviews` is limited to the 10 most recent **approved** reviews. `delivery_info` here is a static placeholder block, not derived from the product's actual `DeliveryRule`s — use `POST products/:id/check_delivery` for a real per-pincode answer.

### Response `404`

```json
{ "success": false, "message": "Product not found" }
```

---

### GET /ecommerce/featured_products

**Public — no auth required.** Cached (`MobileApiCache::PRODUCT_TTL`). Despite the name, this is simply the newest products (`order(created_at: :desc)`), not a curated "featured" flag.

### Query params

| Param | Type | Default | Notes |
|---|---|---|---|
| `limit` | integer | `5` | Capped at `10` |

### Response `200`

```json
{
  "success": true,
  "data": {
    "products": [ { "...": "format_product_data shape" } ],
    "total_count": 5,
    "limit": 5,
    "message_info": "Showing 5 most recent products that came to market"
  },
  "message": "Top 5 recent products retrieved successfully"
}
```

### Response `500`

```json
{
  "success": false,
  "message": "Unable to retrieve featured products",
  "error": "<exception message>",
  "data": { "products": [], "total_count": 0, "limit": 5 }
}
```

---

### GET /ecommerce/search

Auth required. Full-text-ish search via `Product.search(query)` (scoped to `Product.active.available_for_sale`).

### Query params

| Param | Type | Required | Notes |
|---|---|---|---|
| `query` / `q` / `search` | string | Yes | First present of the three is used |
| `page` | integer | No | Default `1` |
| `per_page` | integer | No | Default `20`, capped at `50` |
| `category_id` | integer | No | |
| `min_price` | number | No | |
| `max_price` | number | No | |
| `sort_by` | string | No | `price_low`, `price_high`, `name`, `newest`, `rating`; default is `by_stock_availability` |

### Response `200`

```json
{
  "success": true,
  "data": {
    "products": [ { "...": "format_product_data shape" } ],
    "search_query": "milk",
    "pagination": {
      "current_page": 1,
      "per_page": 20,
      "total_count": 8,
      "total_pages": 1,
      "has_next_page": false,
      "has_prev_page": false
    },
    "applied_filters": {
      "category_id": null,
      "min_price": null,
      "max_price": null,
      "sort_by": null
    }
  },
  "message": "Found 8 products for 'milk'"
}
```

### Response `400` — missing query

```json
{
  "success": false,
  "message": "Search query is required",
  "data": {
    "products": [],
    "search_query": null,
    "pagination": { "current_page": 1, "per_page": 20, "total_count": 0, "total_pages": 0, "has_next_page": false, "has_prev_page": false }
  }
}
```

### Response `500` — unexpected error

```json
{
  "success": false,
  "message": "An error occurred while searching products",
  "data": {
    "products": [],
    "search_query": "milk",
    "pagination": { "current_page": 1, "per_page": 20, "total_count": 0, "total_pages": 0, "has_next_page": false, "has_prev_page": false }
  }
}
```

---

### POST /ecommerce/products/:id/check_delivery

Auth required. Checks deliverability for **one product** using that product's own `DeliveryRule`s (not the global `DeliveryCharge` table — see note above). `@product` is scoped to `Product.active`.

### Body params

| Param | Type | Required | Notes |
|---|---|---|---|
| `pincode` | string | Yes | |

### Response `200` — deliverable

```json
{
  "success": true,
  "data": {
    "product_id": 501,
    "pincode": "560001",
    "deliverable": true,
    "estimated_days": 3,
    "delivery_charge": 40.0,
    "message": "Delivery available in 3 days"
  },
  "message": "Delivery available"
}
```

### Response `200` — not deliverable

```json
{
  "success": true,
  "data": {
    "product_id": 501,
    "pincode": "999999",
    "deliverable": false,
    "estimated_days": null,
    "delivery_charge": 0.0,
    "message": "Delivery not available in this area"
  },
  "message": "Delivery not available"
}
```

Note: `success` is `true` here even when `deliverable` is `false` — only a missing pincode or a missing product produces a non-2xx response. Check `data.deliverable`, not the top-level `success`, to know whether delivery is possible.

### Error responses

| Condition | Status | Body |
|---|---|---|
| Missing `pincode` | 400 | `{ "success": false, "message": "Pincode is required" }` |
| Product not found / not active | 404 | `{ "success": false, "message": "Product not found" }` |

---

### POST /ecommerce/check_delivery

Auth required. Checks deliverability for a **pincode alone**, against the global `DeliveryCharge` table (`ecommerce#check_delivery_by_pincode`).

### Body params

| Param | Type | Required | Notes |
|---|---|---|---|
| `pincode` | string | Yes | Whitespace-trimmed; not otherwise validated for format |

### Response `200` — deliverable

```json
{
  "success": true,
  "data": {
    "pincode": "560001",
    "deliverable": true,
    "delivery_charge": 40.0,
    "area": "Bangalore Central",
    "message": "Delivery available to 560001"
  },
  "message": "Delivery available"
}
```

### Response `200` — not deliverable

```json
{
  "success": true,
  "data": {
    "pincode": "999999",
    "deliverable": false,
    "delivery_charge": null,
    "area": null,
    "message": "Delivery not available to this pincode"
  },
  "message": "Delivery not available"
}
```

Again `success` stays `true` for a not-deliverable pincode.

### Response `400`

```json
{ "success": false, "message": "Pincode is required" }
```

---

### GET /ecommerce/filters

Auth required. Returns the filter facets for the products/search UI, cached (`MobileApiCache::FILTER_TTL`).

### Response `200`

```json
{
  "success": true,
  "data": {
    "categories": [ { "id": 3, "name": "Dairy" } ],
    "price_range": {
      "min": 10.0,
      "max": 8500.0,
      "suggested_ranges": [
        { "label": "Under ₹500", "min": 0, "max": 500 },
        { "label": "₹500 - ₹1000", "min": 500, "max": 1000 },
        { "label": "₹1000 - ₹5000", "min": 1000, "max": 5000 },
        { "label": "₹5000 - ₹10000", "min": 5000, "max": 10000 },
        { "label": "Above ₹10000", "min": 10000, "max": null }
      ]
    },
    "brands": ["Amul", "Nestle"],
    "sort_options": [
      { "key": "newest", "label": "Newest First" },
      { "key": "price_low", "label": "Price: Low to High" },
      { "key": "price_high", "label": "Price: High to Low" },
      { "key": "name", "label": "Name A-Z" },
      { "key": "rating", "label": "Highest Rated" }
    ]
  },
  "message": "Filter options retrieved successfully"
}
```

`categories`/`price_range` are computed from `Category.active`/`Product.active`; `brands` is a distinct, non-blank `Product.active.brand` list (silently becomes `[]` if the query errors, e.g. missing column).

---

### GET /ecommerce/banners

**Public — no auth required.** Cached per `location` (`MobileApiCache::BANNER_TTL`).

### Query params

| Param | Type | Default | Notes |
|---|---|---|---|
| `location` | string | `"home"` | Passed to `Banner.by_location` |

### Response `200`

```json
{
  "success": true,
  "data": {
    "banners": [
      {
        "id": 12,
        "title": "Monsoon Sale",
        "description": "Up to 30% off dairy",
        "image_url": "https://.../banner.jpg",
        "thumbnail_url": "https://.../banner_thumb.jpg",
        "redirect_link": "/products?category_id=3",
        "display_location": "home",
        "display_order": 1,
        "display_start_date": "2026-08-01",
        "display_end_date": "2026-09-01",
        "is_active": true,
        "has_image": true
      }
    ],
    "total_count": 1,
    "location": "home"
  },
  "message": "Banners retrieved successfully"
}
```

Only currently-active banners (`Banner.active.current.by_location(location).ordered`) are returned.

---

### GET /ecommerce/delivery/check-pincode/:pincode

Auth required. Validates a pincode against the external India Post lookup API (`api.postalpincode.in`), with Rails caching of successful lookups (`MobileApiCache::PINCODE_TTL`). This is a district/state/serviceability check, **not** a delivery-charge lookup.

### Path params

| Param | Type | Required | Notes |
|---|---|---|---|
| `pincode` | string | Yes | Must be exactly 6 digits |

### Response `200` — valid pincode

```json
{
  "success": true,
  "data": {
    "valid": true,
    "pincode": "560001",
    "district": "Bangalore",
    "state": "Karnataka",
    "country": "India",
    "post_offices": ["Bangalore GPO", "Cubbon Park"],
    "serviceable": true
  },
  "message": "Pincode is serviceable"
}
```

### Response `200` — invalid/unserviceable pincode

Note: the controller sets the top-level `success` to `validation_result[:valid]`, but `render json:` with only a body (no `status:` override) still returns HTTP **200** even when `success` is `false` — the failure only shows in the JSON payload, not the HTTP status.

```json
{
  "success": false,
  "data": { "valid": false, "error": "Invalid pincode or area not serviceable", "pincode": "999999" },
  "message": "Pincode not serviceable"
}
```

```json
{
  "success": false,
  "data": { "valid": false, "error": "Pincode must be 6 digits" },
  "message": "Pincode not serviceable"
}
```

If the external API call itself fails/times out, `data` is `{ "valid": false, "error": "Unable to validate pincode at this time", "details": "<exception message>" }` (still HTTP 200).

### Response `400`

```json
{ "success": false, "message": "Pincode is required" }
```

---

### POST /ecommerce/delivery/validate

Auth required. Validates a pincode (via the same external India Post check as above) and then, for each product id given, checks stock + that product's own `DeliveryRule`s (same mechanism as `check_delivery`, not the global `DeliveryCharge` table).

### Body params

| Param | Type | Required | Notes |
|---|---|---|---|
| `pincode` | string | Yes | Also accepted nested at `ecommerce[pincode]` |
| `product_ids` | array of integers | Yes (one of `product_ids`/`product_id`) | |
| `product_id` | integer | — | Singular fallback if `product_ids` isn't given |
| `delivery_date` | string | No | Echoed back only, not validated |

### Response `200` — all deliverable

```json
{
  "success": true,
  "data": {
    "pincode": "560001",
    "delivery_date": "2026-08-25",
    "pincode_valid": true,
    "location_info": { "valid": true, "pincode": "560001", "district": "Bangalore", "state": "Karnataka", "country": "India", "post_offices": ["..."], "serviceable": true },
    "overall_delivery_available": true,
    "products": [
      {
        "product_id": 501,
        "product_name": "Full Cream Milk 1L",
        "product_sku": "MLK-1L-001",
        "price": 55.0,
        "stock_available": true,
        "stock_quantity": 120,
        "delivery_available": true,
        "estimated_delivery_days": 3,
        "delivery_charge": 40.0,
        "reasons": []
      }
    ],
    "unavailable_products": [],
    "summary": {
      "total_products": 1,
      "deliverable_products": 1,
      "unavailable_products": 0,
      "total_delivery_charge": 40.0
    }
  },
  "message": "All products can be delivered to 560001"
}
```

### Response `200` — invalid pincode (note: still HTTP 200, `success: false`)

```json
{
  "success": false,
  "data": {
    "pincode": "999999",
    "pincode_valid": false,
    "location_info": { "valid": false, "error": "Invalid pincode or area not serviceable", "pincode": "999999" },
    "delivery_available": false,
    "products": []
  },
  "message": "Invalid pincode"
}
```

### Response `200` — some/all products unavailable (also HTTP 200; `success` mirrors `overall_delivery_available`)

Per-product `reasons` can include `"Product is out of stock"`, `"Delivery not available in this area"`, or (for an unknown id) `"Product not found"` — an unknown product id yields a stub entry with `product_name: "Unknown"`, `price: 0`, zeroed stock/charge fields.

### Error responses

| Condition | Status | Body |
|---|---|---|
| Missing `pincode` or `product_ids` | 400 | `{ "success": false, "message": "Pincode and Product IDs are required" }` |
| Unexpected exception | 500 | `{ "success": false, "message": "An error occurred while validating delivery", "error": "<exception message>" }` |

---

### POST /ecommerce/delivery/charges

Auth required. Looks up the delivery charge for a pincode from the global `DeliveryCharge` table (independent of any product).

### Body params

| Param | Type | Required | Notes |
|---|---|---|---|
| `pincode` | string | Yes | Non-digit characters are stripped before validation; must resolve to exactly 6 digits |
| `address` | string | No | Echoed back only, not used for lookup |

### Response `200`

```json
{
  "success": true,
  "message": "Delivery charges calculated successfully",
  "data": {
    "pincode": "560001",
    "address": "12 MG Road",
    "area": "Bangalore Central",
    "delivery_charge": 40.0,
    "formatted_charge": "₹40.0",
    "is_deliverable": true,
    "delivery_available": true
  }
}
```

### Error responses

| Condition | Status | Body |
|---|---|---|
| Missing `pincode` | 422 | `{ "success": false, "message": "Pincode is required", "error": "Missing pincode parameter" }` |
| Pincode not 6 digits after stripping non-numerics | 422 | `{ "success": false, "message": "Invalid pincode format. Pincode should be 6 digits.", "error": "Invalid pincode format", "data": { "pincode": "...", "address": null, "delivery_charge": 0.0, "is_deliverable": false } }` |
| No `DeliveryCharge` row for pincode | 422 | `{ "success": false, "message": "Delivery not available for this pincode", "error": "Pincode not serviceable", "data": { "pincode": "999999", "address": null, "delivery_charge": 0.0, "is_deliverable": false, "delivery_available": false, "suggested_message": "We don't currently deliver to pincode 999999. Please contact support for more information." } }` |
| Unexpected exception | 500 | `{ "success": false, "message": "An error occurred while calculating delivery charges", "error": "<exception message>", "data": { "pincode": "...", "address": "...", "delivery_charge": 0.0, "is_deliverable": false } }` |

---

### POST /ecommerce/location/save

Auth required. Updates the authenticated customer's stored lat/long (and optionally address). Customer is resolved by `email` from the JWT, not by an id in the body.

### Body params

| Param | Type | Required | Notes |
|---|---|---|---|
| `latitude` | number | Yes | |
| `longitude` | number | Yes | |
| `address` | string | No | Only applied if present |
| `pincode` | string | No | **Not persisted** — `Customer` has no pincode column; it's simply echoed back in the response |

### Response `200`

```json
{
  "success": true,
  "data": {
    "customer_id": 88,
    "latitude": 12.9716,
    "longitude": 77.5946,
    "address": "12 MG Road, Bangalore",
    "pincode": "560001",
    "location_saved_at": "2026-08-23T11:00:00+05:30"
  },
  "message": "Location saved successfully"
}
```

### Error responses

| Condition | Status | Body |
|---|---|---|
| No matching `Customer` for the token's email | 404 | `{ "success": false, "message": "Customer not found" }` |
| Missing `latitude` or `longitude` | 400 | `{ "success": false, "message": "Latitude and longitude are required" }` |
| Customer validation fails on update | 422 | `{ "success": false, "message": "Failed to save location", "errors": ["..."] }` |

---

### GET /ecommerce/profile

Auth required (`customer_profile` action). Customer is resolved by `email` from the JWT.

### Response `200`

```json
{
  "success": true,
  "data": {
    "id": 88,
    "customer_type": "individual",
    "first_name": "Asha",
    "last_name": "K",
    "middle_name": null,
    "full_name": "Asha K",
    "email": "asha@example.com",
    "mobile": "9876543210",
    "whatsapp_number": "9876543210",
    "address": "12 MG Road, Bangalore",
    "gender": "female",
    "marital_status": "single",
    "birth_date": "1995-04-10",
    "pan_no": null,
    "gst_no": null,
    "company_name": null,
    "occupation": "Engineer",
    "annual_income": null,
    "nationality": "Indian",
    "blood_group": "O+",
    "emergency_contact_name": null,
    "emergency_contact_number": null,
    "preferred_language": "en",
    "longitude": 77.5946,
    "latitude": 12.9716,
    "notes": null,
    "status": "active",
    "statistics": {
      "total_orders": 14,
      "total_bookings": 6,
      "total_spent": 4820.0,
      "member_since": "2025-01-15T10:00:00+05:30"
    },
    "recent_activity": {
      "orders": [ { "...": "format_order_data(basic: true) — up to 5 most recent" } ],
      "bookings": [ { "...": "format_booking_data(basic: true) — up to 5 most recent" } ]
    }
  },
  "message": "Profile retrieved successfully"
}
```

`customer_type` is always the literal string `"individual"` (the underlying column doesn't exist). `total_spent` excludes orders with status `cancelled` or `returned`. `recent_activity.orders`/`bookings` are in `basic` form — no line items, just header fields (see `format_order_data`/`format_booking_data` in the bookings/orders doc for the full basic-mode field list).

### Response `404`

```json
{ "success": false, "message": "Customer not found" }
```

---

### PUT /ecommerce/profile

Auth required. Updates the authenticated customer's profile fields. Customer is resolved by `email` from the JWT — this endpoint cannot change email or id.

### Body params

Accepts the same permitted field set whether nested under `customer`, nested under `ecommerce`, or passed at the top level (checked in that order — `customer` wins if both `customer` and `ecommerce` keys are present):

| Field | Type |
|---|---|
| `first_name`, `last_name`, `middle_name` | string |
| `mobile`, `whatsapp_number` | string |
| `address` | string |
| `gender`, `marital_status` | string |
| `birth_date` | date |
| `pan_no`, `gst_no` | string |
| `company_name`, `occupation` | string |
| `annual_income` | number |
| `nationality`, `blood_group` | string |
| `emergency_contact_name`, `emergency_contact_number` | string |
| `preferred_language` | string |
| `longitude`, `latitude` | number |
| `notes` | string |

All optional — only supplied fields are updated.

### Response `200`

```json
{
  "success": true,
  "data": {
    "id": 88,
    "first_name": "Asha",
    "last_name": "K",
    "middle_name": null,
    "full_name": "Asha K",
    "email": "asha@example.com",
    "mobile": "9876543210",
    "whatsapp_number": "9876543210",
    "address": "12 MG Road, Bangalore",
    "gender": "female",
    "marital_status": "single",
    "birth_date": "1995-04-10",
    "pan_no": null,
    "gst_no": null,
    "company_name": null,
    "occupation": "Engineer",
    "annual_income": null,
    "nationality": "Indian",
    "blood_group": "O+",
    "emergency_contact_name": null,
    "emergency_contact_number": null,
    "preferred_language": "en",
    "longitude": 77.5946,
    "latitude": 12.9716,
    "notes": null,
    "status": "active"
  },
  "message": "Profile updated successfully"
}
```

### Error responses

| Condition | Status | Body |
|---|---|---|
| No matching `Customer` for the token's email | 404 | `{ "success": false, "message": "Customer not found" }` |
| Validation fails | 422 | `{ "success": false, "message": "Profile update failed", "errors": ["..."] }` |

---

### Notes for client implementation

- Almost everything in this section requires a bearer token — only `products`, `banners`, and `featured_products` are public. Don't assume plain catalog browsing works unauthenticated.
- `deliverable`/`success` semantics are inconsistent across the delivery endpoints: `check_delivery`, `check_delivery_by_pincode`, `check_pincode`, and `delivery/validate` all return HTTP **200** even for a "not deliverable"/"invalid" result — check the `deliverable`/`pincode_valid`/`overall_delivery_available` field inside `data`, not just the HTTP status or (for the first two) even the top-level `success` flag. `delivery/charges`, by contrast, uses a real `422` for an unserviceable pincode.
- Three separate delivery-data sources exist (product `DeliveryRule`s, the global `DeliveryCharge` table, and the external India Post pincode API) — pick the right endpoint for what you're asking. `product_details`'s embedded `delivery_info` block is a static placeholder, not real data; use `POST products/:id/check_delivery` for an accurate answer.
- Listing/search/filter results and category/product detail responses are Rails-cached (`Rails.cache.fetch`) per distinct param combination — expect brief staleness after admin-side catalog edits, bounded by each endpoint's TTL constant on `MobileApiCache`.
- `page`/`per_page` conventions are consistent throughout this section: 1-indexed `page`, `per_page` defaulting to `20` and capped at `50` (product/category/search listings) — `featured_products`' `limit` is separate, defaulting to `5` and capped at `10`.
## E-commerce — Bookings, Checkout, Orders & Subscriptions

Base URL prefix: `/api/v1/mobile`

All endpoints on this page require authentication:

```
Authorization: Bearer <jwt_token>
```

Token must decode to `role: "customer"` and resolve to a `Customer` record (see `Api::V1::Mobile::BaseController#authenticate_customer!`). Standard auth failures:

| Condition | Status | Body |
|---|---|---|
| Missing header | 401 | `{ "success": false, "message": "Authorization token is required" }` |
| Invalid token | 401 | `{ "success": false, "message": "Invalid authorization token" }` |
| Token valid, no matching customer | 401 | `{ "success": false, "message": "Customer account not found" }` |

Several endpoints below additionally do their own `Customer.find_by(email: @current_user&.email)` (or use `@current_user` directly) and return a distinct `404 { "success": false, "message": "Customer not found" }` if that lookup fails — noted per-endpoint.

There are **two separate ways to place an order** in this controller, with different payment models — see "Two booking flows" below before integrating.

---

### Two booking flows

| | `POST ecommerce/bookings` (`create_booking`) | `POST ecommerce/checkout/cart_order` (`cart_order`) |
|---|---|---|
| Intended use | General booking creation; supports wallet payment | Cart checkout with COD or Cashfree online payment |
| Customer resolution | Required `booking[customer_id]` param | `booking[customer_id]` if given, else the authenticated customer |
| Stock/availability check | Validates every product exists first; returns `422` listing unavailable products before creating anything | No pre-check; raises `404` if a product isn't found mid-transaction |
| Payment | Cash/whatever `payment_method` string is passed, optionally topped up from wallet (`use_wallet`) | `cod` (immediate `confirmed` booking) or any other value → routed through Cashfree (`draft` booking + payment session) |
| Booking status on creation | `ordered_and_delivery_pending` | `confirmed` (COD) or `draft` (Cashfree, until payment completes) |

Booking `status` values: `draft`, `ordered_and_delivery_pending`, `confirmed`, `processing`, `packed`, `shipped`, `out_for_delivery`, `delivered`, `completed`, `cancelled`, `returned`.

Booking `payment_status` values: `unpaid`, `paid`, `partially_paid`, `refunded`.

---

### POST /ecommerce/bookings

Creates a booking directly (not via the Cashfree checkout flow). Controller action: `create_booking`.

#### Request body

All fields are nested under `booking`.

| Field | Type | Required | Notes |
|---|---|---|---|
| `booking[customer_id]` | integer | **Yes** | Must resolve to an existing `Customer`. |
| `booking[delivery_address]` | string | **Yes** | |
| `booking[pincode]` | string | **Yes** | Used for delivery-charge lookup per item and saved to the customer's location. |
| `booking[customer_name]` | string | No | |
| `booking[customer_email]` | string | No | |
| `booking[customer_phone]` | string | No | |
| `booking[payment_method]` | string | No | Free-form; e.g. `cash`, `upi`, `cod`. Not validated against the enum here — persisted as given. |
| `booking[notes]` | string | No | |
| `booking[latitude]` / `booking[longitude]` | float | No | If either (or pincode) is present, saved onto the customer record as their last-known location. |
| `booking[use_wallet]` | boolean | No | See "Wallet payment" below. |
| `booking[is_pre_booking]` | boolean | No | Marks this as a **pre-booking** (an out-of-stock reservation that waits for admin approve/reject before moving to `confirmed`). Only honoured while the admin has the feature on — `SystemSetting.allow_pre_booking_enabled?`, surfaced to the app as `is_pre_booking_enabled` in the login response. When the setting is off the flag is ignored and a normal booking is created (`is_pre_booking: false`). Wallet payment is still allowed on a pre-booking. |
| `booking[booking_items_attributes]` | array | **Yes** (effectively) | Array of `{ product_id, product_variant_id, quantity, price }`. An empty/absent array creates a booking with no items. |

Each `booking_items_attributes` entry:

| Field | Type | Notes |
|---|---|---|
| `product_id` | integer | Must reference an active product or the whole request fails (see below). |
| `product_variant_id` | integer | Only relevant when the product `has_multiple_quantities?`. |
| `quantity` | numeric | |
| `price` | numeric | Client-supplied line price; not recalculated from the product's current price. |

Note: unlike the admin panel, the mobile API allows booking **past available stock** — a shortage is reported for display but never blocks the request (`skip_stock_check = true` is set on the booking).

#### Success response `201`

```json
{
  "success": true,
  "data": {
    "id": 4521,
    "booking_number": "BK20260823A1B2C3",
    "booking_date": "2026-08-23T10:15:22+05:30",
    "status": "ordered_and_delivery_pending",
    "is_pre_booking": false,
    "pending_pre_booking_approval": false,
    "payment_status": "unpaid",
    "payment_method": "cash",
    "subtotal": 200.0,
    "tax_amount": 0.0,
    "discount_amount": 0.0,
    "delivery_charge": 40.0,
    "delivery_charge_label": "₹40.0",
    "total_amount": 240.0,
    "wallet_amount_used": 0.0,
    "paid_via_wallet": false,
    "wallet_transaction_id": null,
    "customer_name": "Jane Doe",
    "customer_email": "jane@example.com",
    "customer_phone": "9876543210",
    "delivery_address": "12 MG Road, Bengaluru",
    "notes": null,
    "invoice_number": null,
    "invoice_generated": false,
    "created_at": "2026-08-23T10:15:22+05:30",
    "updated_at": "2026-08-23T10:15:22+05:30",
    "items": [
      {
        "id": 9001,
        "product_id": 55,
        "product_name": "Full Cream Milk 1L",
        "product_sku": "MLK-1L",
        "quantity": 2,
        "price": 100.0,
        "total": 200.0
      }
    ],
    "location_saved": { "latitude": null, "longitude": null, "pincode": "560001" },
    "available_products": [
      {
        "product_id": 55,
        "product_name": "Full Cream Milk 1L",
        "requested_quantity": 2.0,
        "available_stock": 40.0,
        "price": 100.0,
        "delivery_charge": 40.0
      }
    ],
    "stock_updated": true,
    "wallet_note": null
  },
  "message": "Booking created successfully with product availability verified"
}
```

`franchise` is added to the payload only if the booking ends up linked to a franchise.

#### Wallet payment

`booking[use_wallet]: true` opts this booking into paying (fully or partially) from the customer's wallet balance before falling back to `payment_method` for any remainder. This behavior — the deduction formula, the resulting `payment_status`/`payment_method` values, `wallet_amount_used`/`paid_via_wallet`/`wallet_transaction_id`/`wallet_note` response fields, and the feature flag (`SystemSetting.customer_wallet_enabled?`) — is fully documented in [`CUSTOMER_WALLET_API.md`](./CUSTOMER_WALLET_API.md#post-ecommercebookings--paying-with-wallet). Nothing else about this endpoint changes when `use_wallet` is used.

#### Error responses

| Status | Condition | Body |
|---|---|---|
| 422 | Missing `customer_id`, `delivery_address`, or `pincode` | `{ "success": false, "message": "Required fields are missing", "missing_fields": [...], "required_fields": { "customer_id": "...", "delivery_address": "...", "pincode": "..." } }` |
| 404 | `customer_id` doesn't resolve to a `Customer` | `{ "success": false, "message": "Customer not found", "error": "Please provide a valid customer_id" }` |
| 422 | One or more `booking_items_attributes[].product_id` don't resolve to an active `Product` | `{ "success": false, "message": "Some products are not available for booking", "data": { "unavailable_products": [{ "product_id": ..., "product_name": "Unknown", "requested_quantity": ..., "available_stock": 0, "reason": "Product not found" }], "available_products": [...], "pincode_info": null, "location_info": { "pincode", "latitude", "longitude" } } }` |
| 422 | Booking fails model validation (e.g. bad `total_amount`) | `{ "success": false, "message": "Booking creation failed", "errors": [...], "booking_attributes": {...}, "available_products": [...] }` |
| 500 | Unexpected error during save | `{ "success": false, "message": "Booking creation failed due to system error", "error": "<exception message>", "available_products": [...] }` |

---

### GET /ecommerce/bookings

Lists the authenticated customer's bookings. Controller action: `bookings`.

Looks up the customer via `Customer.find_by(email: @current_user&.email)` — returns `404 { "success": false, "message": "Customer not found" }` if that fails.

#### Query params

| Param | Type | Default | Notes |
|---|---|---|---|
| `page` | integer | `1` | |
| `per_page` | integer | `20` | Capped at `50` |
| `status` | string | — | Filters by exact `booking.status` value |

#### Response `200`

```json
{
  "success": true,
  "data": {
    "bookings": [ /* array of booking objects, same shape as create_booking's data (items included) */ ],
    "user_type": "customer",
    "pagination": {
      "current_page": 1,
      "per_page": 20,
      "total_count": 12,
      "total_pages": 1,
      "has_next_page": false,
      "has_prev_page": false
    }
  },
  "message": "Bookings retrieved successfully"
}
```

Ordered most-recent-first (`.recent`).

---

### GET /ecommerce/bookings/:id/payment_status

Lightweight polling endpoint for Cashfree payment status on a single booking. Controller action: `payment_status`.

Requires `@current_user` to be a `Customer` directly (no separate lookup by email); scoped to `customer.bookings`.

#### Response `200`

```json
{
  "success": true,
  "data": {
    "booking_id": 4521,
    "booking_number": "MKS_20260823101522_AB12CD34",
    "status": "confirmed",
    "payment_status": "paid",
    "payment_method": "cashfree",
    "payment_gateway": "cashfree",
    "cashfree_order_id": "MKS_20260823101522_AB12CD34",
    "cashfree_payment_id": "1234567890",
    "total_amount": 240.0,
    "payment_initiated_at": "2026-08-23T10:15:22+05:30",
    "payment_completed_at": "2026-08-23T10:16:05+05:30",
    "is_paid": true,
    "is_pending": false
  },
  "message": "Payment completed successfully"
}
```

`message` is `"Payment completed successfully"` when `payment_successful?`, `"Payment is pending"` when `payment_pending?` (initiated but not yet completed and still unpaid), otherwise `"Payment status retrieved"`.

#### Error responses

| Status | Condition | Body |
|---|---|---|
| 404 | `@current_user` isn't a `Customer` | `{ "success": false, "message": "Customer not found" }` |
| 404 | No booking with that `id` owned by this customer | `{ "success": false, "message": "Booking not found" }` |

---

### POST /ecommerce/checkout/cart_order

Cart checkout endpoint — creates a booking from cart items and either confirms it immediately (COD) or opens a Cashfree payment session. Controller action: `cart_order`.

#### Request body

All fields nested under `booking`, same shape as `booking_items_attributes` above.

| Field | Type | Required | Notes |
|---|---|---|---|
| `booking[customer_id]` | integer | No | Falls back to the authenticated customer if omitted. |
| `booking[booking_items_attributes]` | array | **Yes** | `422`-equivalent (`400`) if blank — see errors below. Each item: `product_id`, `product_variant_id`, `quantity`, `price`. |
| `booking[payment_method]` | string | No | Defaults to `"cod"`. Any other value routes through Cashfree. |
| `booking[delivery_address]` | string | No | |
| `booking[pincode]` | string | No | Used to look up `DeliveryCharge.charge_for_pincode`, applied as `shipping_charges` if > 0. |
| `booking[customer_name]` / `[customer_email]` / `[customer_phone]` | string | No | Default to the customer's own `display_name`/`email`/`mobile`. |
| `booking[notes]` | string | No | |
| `booking[latitude]` / `booking[longitude]` | float | No | Saved onto the customer if either is present. |

Note: `booking[use_wallet]` is **not** permitted/supported on this endpoint (wallet payment is only available via `create_booking`).

`total_amount`/`subtotal` are computed server-side as `sum(price * quantity)` over the submitted items (client-supplied `price`, not re-priced from the product).

#### Success response — COD (`200`)

```json
{
  "success": true,
  "message": "Order placed successfully! Pay on delivery.",
  "booking_number": "BK20260823A1B2C3",
  "booking_id": 4521,
  "subtotal": 200.0,
  "delivery_charge": 40.0,
  "total_amount": 240.0,
  "payment_method": "cod"
}
```

The booking is created directly with `status: "confirmed"`, `payment_status: "unpaid"`.

#### Success response — online payment (`200`)

Booking is created with `status: "draft"`, a Cashfree order is opened via `CashfreeService.create_order`:

```json
{
  "success": true,
  "message": "Payment session created. Complete payment using Cashfree SDK.",
  "booking_number": "BK20260823A1B3D4",
  "booking_id": 4522,
  "total_amount": 240.0,
  "payment_method": "cashfree",
  "payment_session_id": "session_abc123...",
  "cashfree_order_id": "MKS_20260823101522_AB12CD34",
  "redirect_to_payment": true
}
```

`cashfree_order_id` is generated by `Booking.generate_cashfree_order_id`. The client is expected to hand `payment_session_id` to the Cashfree Mobile SDK to complete payment, then poll `GET .../payment_status` or call `POST /verify_payment`.

#### Error responses

| Status | Condition | Body |
|---|---|---|
| 404 | No resolvable customer (`customer_id` invalid and not authenticated as a customer) | `{ "success": false, "message": "Customer not found" }` |
| 400 | `booking_items_attributes` blank | `{ "success": false, "message": "Cart is empty" }` |
| 422 | A cart item references a product that doesn't resolve to a `Product` (raised as `ActiveRecord::RecordNotFound`) | `{ "success": false, "message": "Product not found in cart" }` |
| 422 | Booking fails model validation | `{ "success": false, "message": "<validation error message>" }` |
| 422 | Cashfree order creation fails (`CashfreeService.create_order` returns `success: false`) | `{ "success": false, "message": "<gateway message, e.g. Client Error detail>" }` — booking is marked `mark_payment_failed!` first |
| 500 | Unexpected error | `{ "success": false, "message": "An unexpected error occurred" }` |

---

### POST /ecommerce/verify_payment

Confirms/refreshes a booking's Cashfree payment status by querying Cashfree directly. Controller action: `verify_payment`.

Requires `@current_user` to be a `Customer`; booking scoped to `customer.bookings`.

#### Request body

| Field | Type | Required | Notes |
|---|---|---|---|
| `booking_id` | integer | **Yes** | Not nested — a top-level param. |

#### Behavior

1. If the booking is already `payment_successful?` (paid + has `cashfree_payment_id`), short-circuits and returns the current state.
2. Otherwise, if `cashfree_order_id` is present, calls `CashfreeService.get_order(cashfree_order_id)`. If Cashfree reports `order_status == "PAID"`, the booking is marked `mark_payment_completed!` (sets `payment_status: paid`, `status: confirmed`, `cashfree_payment_id`, sends the booking confirmation email, generates the invoice).
3. Reloads the booking and returns its (possibly now-updated) status.

#### Response `200` — success is tied to actual payment state, not the HTTP call succeeding

```json
{
  "success": true,
  "data": {
    "booking_id": 4521,
    "booking_number": "BK20260823A1B2C3",
    "status": "confirmed",
    "payment_status": "paid",
    "cashfree_order_id": "MKS_20260823101522_AB12CD34",
    "cashfree_payment_id": "1234567890",
    "total_amount": 240.0,
    "payment_completed_at": "2026-08-23T10:16:05+05:30",
    "is_paid": true
  },
  "message": "Payment verified successfully"
}
```

If Cashfree hasn't confirmed payment yet, the same shape is returned with `"success": false`, `payment_status: "unpaid"`, `is_paid: false`, `message: "Payment not yet completed"` — note this is a `200` response with `success: false` in the body, not an HTTP error status.

#### Error responses

| Status | Condition | Body |
|---|---|---|
| 404 | `@current_user` isn't a `Customer` | `{ "success": false, "message": "Customer not found" }` |
| 400 | `booking_id` missing | `{ "success": false, "message": "booking_id is required" }` |
| 404 | No booking with that id owned by this customer | `{ "success": false, "message": "Booking not found" }` |
| 500 | Unexpected error (e.g. Cashfree call raises) | `{ "success": false, "message": "Unable to verify payment" }` |

---

### GET /ecommerce/orders

Lists the authenticated customer's `Order` records (distinct from `Booking`s — see Orders vs Bookings note below). Controller action: `orders`.

Looks up the customer via `Customer.find_by(email: @current_user&.email)` — `404` if not found.

#### Query params

| Param | Type | Default | Notes |
|---|---|---|---|
| `page` | integer | `1` | |
| `per_page` | integer | `20` | Capped at `50` |
| `status` | string | — | Filters by exact `order.status` |

#### Response `200`

```json
{
  "success": true,
  "data": {
    "orders": [
      {
        "id": 301,
        "order_number": "ORD-2026-0301",
        "order_date": "2026-08-20T09:00:00+05:30",
        "status": "delivered",
        "payment_status": "paid",
        "payment_method": "upi",
        "subtotal": 500.0,
        "tax_amount": 0.0,
        "discount_amount": 0.0,
        "shipping_amount": 0.0,
        "total_amount": 500.0,
        "customer_name": "Jane Doe",
        "customer_email": "jane@example.com",
        "customer_phone": "9876543210",
        "delivery_address": "12 MG Road, Bengaluru",
        "tracking_number": null,
        "delivered_at": "2026-08-22T14:30:00+05:30",
        "notes": null,
        "created_at": "2026-08-20T09:00:00+05:30",
        "updated_at": "2026-08-22T14:30:00+05:30",
        "items": [
          {
            "id": 5001,
            "product_id": 55,
            "product_name": "Full Cream Milk 1L",
            "product_sku": "MLK-1L",
            "product_image": "https://.../milk.jpg",
            "quantity": 5,
            "price": 100.0,
            "total": 500.0
          }
        ]
      }
    ],
    "pagination": {
      "current_page": 1,
      "per_page": 20,
      "total_count": 3,
      "total_pages": 1,
      "has_next_page": false,
      "has_prev_page": false
    }
  },
  "message": "Orders retrieved successfully"
}
```

Note: the list endpoint includes `items` on every row (`format_order_data` is called without `basic: true`), unlike `format_booking_data` where `items` is also included by default on the list endpoint too — both list endpoints return full item detail per row.

---

### GET /ecommerce/orders/:id

Single order detail. Controller action: `order_details`. Scoped to `customer.orders`.

#### Response `200`

Same shape as one entry in `GET /ecommerce/orders`'s `orders` array (via `format_order_data(@order, include_items: true)`).

```json
{
  "success": true,
  "data": { "id": 301, "order_number": "ORD-2026-0301", "...": "..." },
  "message": "Order details retrieved successfully"
}
```

#### Error responses

| Status | Condition | Body |
|---|---|---|
| 404 | `@current_user` email doesn't resolve to a `Customer` | `{ "success": false, "message": "Customer not found" }` |
| 404 | No order with that `id` owned by this customer | `{ "success": false, "message": "Order not found" }` |

---

### Subscriptions

**Important implementation note:** despite the route/param name `subscription`, all five subscription endpoints operate on the `MilkSubscription` model, not a generic e-commerce "Subscription" — this is a recurring milk-delivery feature (each active subscription auto-generates `MilkDeliveryTask` rows for its date range on creation). There is a `format_subscription_data` helper defined in the controller that describes a different-shaped, generic subscription object (`schedule_type`, `next_booking_date`, etc.) — it is dead code, never called by any route; ignore it. The response shape actually used everywhere is `format_milk_subscription_data`, documented below.

`MilkSubscription.status` values: `active`, `paused`, `expired`, `cancelled`.

#### State transitions

| Action | Allowed from | Resulting status |
|---|---|---|
| `pause` | `active` | `paused` |
| `resume` | `paused` | `active` |
| `cancel` | anything except `cancelled` | `cancelled` |

Each transition is a plain `update!(status: ...)` — it does **not** call the model's `pause_all_tasks!`/`resume_all_tasks!` (which also toggle `is_active` and bulk-update the linked `milk_delivery_tasks`); the mobile pause/resume/cancel actions only flip the `status` column.

---

### POST /ecommerce/subscriptions

Creates a new milk subscription. Controller action: `create_subscription`. Requires `@current_user` to be a `Customer` directly.

#### Request body

All fields nested under `subscription`.

| Field | Type | Required | Notes |
|---|---|---|---|
| `subscription[product_id]` | integer | **Yes** (model-level) | |
| `subscription[pincode]` | string | **Yes** | Validated via `validate_pincode` (calls an external postal-pincode API, cached); request fails if invalid/unserviceable. |
| `subscription[quantity]` | numeric | No | Defaults to `1`. |
| `subscription[frequency]` | string | No | One of `daily`, `weekly`/`alternate`, `specific`/`custom` (anything else → `daily`). Mapped internally to `delivery_pattern`. |
| `subscription[start_date]` | date | **Yes** (model-level) | |
| `subscription[end_date]` | date | **Yes** (model-level) | Must be `>= start_date`. |
| `subscription[delivery_time]` | string | No | Defaults to `"morning"`. |
| `subscription[delivery_address]` | string | No | Accepted but not persisted onto `MilkSubscription` (the model has no such column used here) — effectively ignored. |
| `subscription[latitude]` / `[longitude]` | float | No | Same — accepted but not passed into `MilkSubscription.new`. |
| `subscription[notes]` | string | No | Accepted but not passed into `MilkSubscription.new` either. |

Unit is hardcoded to `"ltr"`; the new subscription is created with `is_active: true, status: "active"`.

#### Success response `201`

```json
{
  "success": true,
  "data": {
    "id": 88,
    "customer": { "id": 12, "name": "Jane Doe", "email": "jane@example.com", "mobile": "9876543210" },
    "product": { "id": 55, "name": "Full Cream Milk 1L", "price": 100.0 },
    "quantity": 1,
    "unit": "ltr",
    "start_date": "2026-09-01",
    "end_date": "2026-09-30",
    "delivery_time": "morning",
    "delivery_pattern": "daily",
    "status": "active",
    "is_active": true,
    "created_at": "2026-08-23T10:15:22+05:30"
  },
  "message": "Subscription created successfully"
}
```

Creating the record synchronously generates one `MilkDeliveryTask` per delivery date in range (via `after_create :generate_all_delivery_tasks`) — a long date range with `daily` pattern can mean many rows created inline before the response returns.

#### Error responses

| Status | Condition | Body |
|---|---|---|
| 404 | `@current_user` isn't a `Customer` | `{ "success": false, "message": "Customer not found" }` |
| 422 | Pincode invalid/not serviceable | `{ "success": false, "message": "Invalid pincode or delivery not available", "error_details": { "valid": false, "error": "..." } }` |
| 422 | `MilkSubscription` validation fails (e.g. missing `quantity`/`start_date`/`end_date`, `end_date` before `start_date`) | `{ "success": false, "message": "Subscription creation failed", "errors": [...] }` |

---

### GET /ecommerce/subscriptions

Lists the authenticated customer's milk subscriptions. Controller action: `subscriptions`.

#### Query params

| Param | Type | Default | Notes |
|---|---|---|---|
| `page` | integer | `1` | |
| `per_page` | integer | `20` | Capped at `50` |
| `status` | string | — | Filters by exact `status` (`active`/`paused`/`expired`/`cancelled`) |

#### Response `200`

```json
{
  "success": true,
  "data": {
    "subscriptions": [ /* array, same shape as create_subscription's data */ ],
    "pagination": {
      "current_page": 1,
      "per_page": 20,
      "total_count": 2,
      "total_pages": 1,
      "has_next_page": false,
      "has_prev_page": false
    }
  },
  "message": "Subscriptions retrieved successfully"
}
```

#### Error response

| Status | Condition | Body |
|---|---|---|
| 404 | `@current_user` isn't a `Customer` | `{ "success": false, "message": "Customer not found" }` |

---

### GET /ecommerce/subscriptions/:id

Subscription detail plus its 10 most recent delivery tasks. Controller action: `subscription_details`.

#### Response `200`

```json
{
  "success": true,
  "data": {
    "id": 88,
    "customer": { "id": 12, "name": "Jane Doe", "email": "jane@example.com", "mobile": "9876543210" },
    "product": { "id": 55, "name": "Full Cream Milk 1L", "price": 100.0 },
    "quantity": 1,
    "unit": "ltr",
    "start_date": "2026-09-01",
    "end_date": "2026-09-30",
    "delivery_time": "morning",
    "delivery_pattern": "daily",
    "status": "active",
    "is_active": true,
    "created_at": "2026-08-23T10:15:22+05:30",
    "recent_delivery_tasks": [
      {
        "id": 7001,
        "delivery_date": "2026-09-05",
        "quantity": 1,
        "status": "pending",
        "completed_at": null,
        "delivery_person": null
      }
    ]
  },
  "message": "Subscription details retrieved successfully"
}
```

`recent_delivery_tasks` is ordered by `delivery_date desc`, limited to 10. `delivery_person` is `null` unless a delivery person has been assigned to that task.

#### Error responses

| Status | Condition | Body |
|---|---|---|
| 404 | `@current_user` isn't a `Customer` | `{ "success": false, "message": "Customer not found" }` |
| 404 | No subscription with that `id` owned by this customer | `{ "success": false, "message": "Subscription not found" }` |

---

### PUT /ecommerce/subscriptions/:id/pause

Controller action: `pause_subscription`. Only succeeds when current `status == "active"`.

#### Success response `200`

```json
{
  "success": true,
  "data": { "id": 88, "...": "full subscription object, status now \"paused\"" },
  "message": "Subscription paused successfully"
}
```

#### Error responses

| Status | Condition | Body |
|---|---|---|
| 404 | `@current_user` isn't a `Customer` | `{ "success": false, "message": "Customer not found" }` |
| 404 | No subscription with that `id` owned by this customer | `{ "success": false, "message": "Subscription not found" }` |
| 422 | Current status isn't `active` | `{ "success": false, "message": "Cannot pause subscription. Current status: <status>" }` |

---

### PUT /ecommerce/subscriptions/:id/resume

Controller action: `resume_subscription`. Only succeeds when current `status == "paused"`.

#### Success response `200`

```json
{
  "success": true,
  "data": { "id": 88, "...": "full subscription object, status now \"active\"" },
  "message": "Subscription resumed successfully"
}
```

#### Error responses

| Status | Condition | Body |
|---|---|---|
| 404 | `@current_user` isn't a `Customer` | `{ "success": false, "message": "Customer not found" }` |
| 404 | No subscription with that `id` owned by this customer | `{ "success": false, "message": "Subscription not found" }` |
| 422 | Current status isn't `paused` | `{ "success": false, "message": "Cannot resume subscription. Current status: <status>" }` |

---

### PUT /ecommerce/subscriptions/:id/cancel

Controller action: `cancel_subscription`. Succeeds from any status except `cancelled` (e.g. can cancel directly from `active` or `paused`, unlike pause/resume which each require one specific starting status).

#### Success response `200`

```json
{
  "success": true,
  "data": { "id": 88, "...": "full subscription object, status now \"cancelled\"" },
  "message": "Subscription cancelled successfully"
}
```

#### Error responses

| Status | Condition | Body |
|---|---|---|
| 404 | `@current_user` isn't a `Customer` | `{ "success": false, "message": "Customer not found" }` |
| 404 | No subscription with that `id` owned by this customer | `{ "success": false, "message": "Subscription not found" }` |
| 422 | Already `cancelled` | `{ "success": false, "message": "Subscription is already cancelled" }` |

---

### Notes for client implementation

- **Bookings vs Orders are separate resources.** `Booking` (created via `create_booking`/`cart_order`) is the milk-delivery/franchise-style order, while `Order` (listed via `GET /orders`) appears to be a distinct e-commerce order record — the mobile API never creates an `Order` directly; check with backend whether/how orders get created before assuming `cart_order` results show up there.
- **Two payment-initiating endpoints, one gateway.** Only `cart_order` opens a Cashfree session; `create_booking` never talks to Cashfree — its `payment_method` is stored as-is and, if `use_wallet` isn't used, the booking is left `unpaid` for the client/backend to reconcile out of band.
- **`verify_payment` can return `200` with `"success": false`** — always check the `success` key and `payment_status`/`is_paid`, not just HTTP status, when polling payment completion.
- Cashfree order ids are generated as `MKS_<timestamp>_<hex>` (`Booking.generate_cashfree_order_id`) — despite the `MKS` prefix (a holdover naming choice), this is used for the general Cashfree checkout flow, not specifically milk subscriptions.
- For subscriptions, `pause`/`resume` only flip `status` — they do **not** bulk-update already-generated `milk_delivery_tasks` the way the model's own `pause_all_tasks!`/`resume_all_tasks!` would. A paused subscription's existing pending delivery tasks are left untouched by this API.
## Customer Portfolio

Covers the customer's insurance policy list plus upcoming-payment/renewal reminders.

> Wallet (`GET /customer/wallet`) is documented separately — see [Customer Wallet API doc](./CUSTOMER_WALLET_API.md).

Base URL prefix: `/api/v1/mobile`

All endpoints below require authentication and are backed by `Api::V1::Mobile::CustomerController` (`before_action :authenticate_customer!`).

### Authentication

```
Authorization: Bearer <jwt_token>
```

Despite the method name, `authenticate_customer!` (in `Api::V1::Mobile::BaseController`) accepts tokens for any role (`customer`, `agent`, `sub_agent`) and sets `current_user` accordingly. However, **every action in this module calls `current_customer.id` directly with no nil check** — `current_customer` is only populated when the token's role is `"customer"`. A valid `agent`/`sub_agent` token will pass authentication but then raise an unhandled `NoMethodError` (500) inside the action. In practice, these three endpoints are customer-only.

| Condition | Status | Body |
|---|---|---|
| Missing header | 401 | `{ "success": false, "message": "Authorization token is required" }` |
| Invalid/expired token | 401 | `{ "success": false, "message": "Invalid authorization token" }` |
| Decoded role not `customer`/`agent`/`sub_agent` | 401 | `{ "success": false, "message": "Invalid user role" }` |
| Token valid, `role: "customer"`, no matching `Customer` record | 401 | `{ "success": false, "message": "Customer account not found" }` |
| `agent`/`sub_agent` User referenced by token id doesn't exist | 401 | `{ "success": false, "message": "User not found" }` |

Note: `LifeInsurance` is always queried; `MotorInsurance` and (in `upcoming_renewals`) `TravelInsurance`/`GeneralInsurance`/`OtherInsurance` are only queried `if defined?`/`Object.const_defined?`, each wrapped in its own `rescue` that logs a warning and silently skips that insurance type on any DB/table error (relevant given this app previously removed `HealthInsurance` — no health data will ever appear here). Health has no model any more, so it's absent from `portfolio`/`upcoming_installments` entirely, but a vestigial `health: 0` key still ships in `upcoming_renewals`'s `by_insurance_type` (see below).

---

### GET /customer/portfolio

Returns all of the customer's insurance policies plus summary counts. Currently aggregates **Life** and **Motor** insurance only (no Travel/General/Other, unlike `upcoming_renewals`).

No query params.

#### Response `200`

```json
{
  "success": true,
  "data": {
    "portfolio": [
      {
        "id": 101,
        "insurance_name": "HDFC Life Click 2 Protect",
        "insurance_type": "Life",
        "policy_number": "LIC-2026-0011",
        "policy_holder": "Jane Doe",
        "start_date": "2024-01-15",
        "end_date": "2044-01-14",
        "total_premium": 12000.0,
        "sum_insured": 5000000.0,
        "insurance_company": "HDFC Life",
        "payment_mode": "Yearly",
        "status": "Active",
        "days_until_expiry": 6350,
        "attachment": "https://.../rails/active_storage/blobs/...",
        "nominee_name": "John Doe",
        "nominee_relationship": "Spouse",
        "policy_term": 20,
        "premium_payment_term": 10
      },
      {
        "id": 55,
        "insurance_name": "Motor Insurance",
        "insurance_type": "Motor",
        "policy_number": "MOT-2026-0007",
        "policy_holder": "Jane Doe",
        "start_date": "2025-06-01",
        "end_date": "2026-05-31",
        "total_premium": 4500.0,
        "sum_insured": 350000.0,
        "insurance_company": "ICICI Lombard",
        "payment_mode": "Yearly",
        "status": "Expiring Soon",
        "days_until_expiry": 45,
        "attachment": null
      }
    ],
    "total_policies": 2,
    "total_premium": 16500.0,
    "total_sum_insured": 5350000.0,
    "active_policies": 1,
    "expiring_policies": 1,
    "portfolio_summary": {
      "total_policies": 2,
      "upcoming_installments": 0,
      "renewal_policies": 1
    }
  }
}
```

Field notes:
- `insurance_type` is `"Life"` or `"Motor"` only.
- `status` is one of `"Active"`, `"Expired"`, `"Expiring Soon"` (life uses `policy.active?`/`policy.expired?`; motor is computed inline by comparing `policy_end_date` to `Date.current` — a motor policy with a blank `policy_end_date` defaults to `"Active"`).
- Life-only fields: `nominee_name`, `nominee_relationship`, `policy_term`, `premium_payment_term` (motor entries omit these keys).
- `sum_insured` for motor is `vehicle_idv` if the model responds to it, else `null`.
- `attachment` is a Rails Active Storage blob URL for the first attached `policy_documents` file, or `null`.
- List is sorted by `start_date` descending (newest first).
- `portfolio_summary` is computed independently (via `get_customer_portfolio_summary`) and includes an `OtherInsurance` count in `total_policies` that isn't reflected in the `portfolio` array itself (only Life + Motor are listed there), so `total_policies` at the top level and `portfolio_summary.total_policies` can differ.

No documented error responses beyond the shared auth table above (no other `render` branch exists in this action).

---

### GET /customer/upcoming_installments

Returns upcoming premium installments (next 60 days) for **Life** and **Motor** policies, including renewal-style installments for policies that expired within the last 18 months.

No query params.

#### Response `200`

```json
{
  "success": true,
  "data": {
    "upcoming_installments": [
      {
        "id": 101,
        "insurance_name": "HDFC Life Click 2 Protect",
        "insurance_type": "Life",
        "policy_number": "LIC-2026-0011",
        "policy_holder": "Jane Doe",
        "insurance_company": "HDFC Life",
        "start_date": "2024-01-15",
        "end_date": "2044-01-14",
        "total_premium": 12000.0,
        "payment_mode": "Yearly",
        "next_installment_date": "2026-09-10",
        "installment_amount": 12000.0,
        "days_until_installment": 18,
        "days_left_from_today": 18,
        "label": "Upcoming",
        "installment_type": "regular",
        "is_expired": false,
        "is_overdue": false,
        "attachment": null
      }
    ],
    "total_installments": 1,
    "total_amount": 12000.0,
    "next_7_days": 0,
    "next_30_days": 1,
    "next_60_days": 1,
    "next_90_days": 1,
    "regular_installments": 1,
    "renewal_installments": 0,
    "overdue_installments": 0,
    "expired_policies": 0,
    "active_policies": 1,
    "next_installment": { "...": "same shape as an item in upcoming_installments, or null if empty" }
  }
}
```

Field notes:
- Policies with `payment_mode` of `"single"`, `"one time"`, or `"lump sum"` (case-insensitive) are excluded — they have no recurring installment.
- `payment_mode` must be one of `monthly`/`quarterly`/`half-yearly`(or `half yearly`)/`yearly` for `next_installment_date` to be computed at all; any other value silently drops the policy from the list.
- `installment_amount` = `total_premium` divided by the number of installments implied by `payment_mode` (12/4/2/1), rounded to 2 decimals.
- `label` is a human string derived from `days_left_from_today`: `"Expired"` (≤0), `"Expiring in N day(s)"` (1–7), `"Coming soon"` (8–29), `"Upcoming"` (≥30).
- `installment_type` is `"regular"` (policy still active, computed off its normal cycle) or `"renewal"` (policy already expired within the last 540 days, computed off `policy_end_date + 1 day`).
- `next_installment` is the single soonest entry (list is sorted by `next_installment_date` ascending), or `null` if there are none.

No documented error responses beyond the shared auth table above.

---

### GET /customer/upcoming_renewals

Returns policies whose `policy_end_date` falls within the next 2 months, across **Life, Motor, Travel, General, and Other** insurance (each of the latter four is only included `if` its model class is defined in the app).

No query params.

#### Response `200`

```json
{
  "success": true,
  "data": {
    "upcoming_renewals": [
      {
        "id": 55,
        "insurance_name": "Motor Insurance",
        "insurance_type": "Motor",
        "policy_number": "MOT-2026-0007",
        "policy_holder": "Jane Doe",
        "start_date": "2025-06-01",
        "end_date": "2026-05-31",
        "renewal_date": "2026-06-01",
        "total_premium": 4500.0,
        "sum_insured": 350000.0,
        "payment_mode": "Yearly",
        "days_until_renewal": 45,
        "renewal_status": "approaching",
        "is_expired": false,
        "days_since_expiry": null,
        "insurance_company": "ICICI Lombard",
        "attachment": null,
        "vehicle_number": "KA01AB1234",
        "vehicle_make": "Maruti",
        "vehicle_model": "Swift"
      }
    ],
    "total_renewals": 1,
    "urgent_renewals": 0,
    "due_soon": 0,
    "approaching": 1,
    "upcoming": 0,
    "overdue": 0,
    "renewal_required": 0,
    "renewal_recommended": 0,
    "active_policies": 1,
    "expired_policies": 0,
    "customer_id": 42,
    "customer_name": "Jane Doe",
    "has_policies": true,
    "by_insurance_type": {
      "health": 0,
      "life": 0,
      "motor": 1,
      "travel": 0,
      "general": 0,
      "other": 0
    },
    "summary": {
      "next_7_days": 0,
      "next_30_days": 0,
      "next_60_days": 1,
      "overdue_count": 0,
      "total_premium_due": 4500.0,
      "most_urgent": { "...": "same shape as an item in upcoming_renewals" },
      "insurance_types_covered": ["Motor"]
    }
  }
}
```

Field notes:
- `renewal_status` logic differs between Life and the other four types:
  - **Life**: `"overdue"` if already past end date; else `"urgent"` (≤7d), `"due_soon"` (≤30d), `"approaching"` (≤60d), `"upcoming"` (>60d).
  - **Motor / Travel / General / Other**: if expired, `"overdue"` (≤30d since expiry), `"renewal_required"` (31–90d), `"renewal_recommended"` (>90d); if not expired, same `urgent`/`due_soon`/`approaching`/`upcoming` tiers as Life.
- `vehicle_number`/`vehicle_make`/`vehicle_model` are only populated (non-null) for `insurance_type: "Motor"` entries; present but `null` on all others.
- `by_insurance_type` always includes a `"health"` key that will always be `0` — `HealthInsurance` was removed from the app and is not part of the `insurance_types` list this action scans; the key appears to be dead/vestigial rather than reflecting real data.
- List sorted overdue-first, then by `days_until_renewal` ascending.
- `most_urgent` is the first (soonest/most overdue) entry, or `null` if the list is empty.

No documented error responses beyond the shared auth table above.

---

## Settings

Profile, password, terms, contact, and helpdesk endpoints, shared across all mobile roles. Backed by `Api::V1::Mobile::SettingsController` (`before_action :authenticate_customer!`).

Base URL prefix: `/api/v1/mobile`

### Authentication

```
Authorization: Bearer <jwt_token>
```

Same `authenticate_customer!` filter as above — see the error table in the Customer Portfolio section. Unlike the Customer Portfolio module, every action here correctly uses the generic `current_user` (works for `Customer`, `User`/agent, and `SubAgent` tokens alike) rather than `current_customer`, so all three roles are actually supported.

---

### GET /settings/profile

Returns the current user's profile. Field set depends on the authenticated user's type.

No params.

#### Response `200` (customer example)

```json
{
  "success": true,
  "data": {
    "username": "jane@example.com",
    "user_image": null,
    "full_name": "Jane Doe",
    "first_name": "Jane",
    "last_name": "Doe",
    "email": "jane@example.com",
    "mobile_number": "9876543210",
    "gender": "Female",
    "age": 34,
    "birth_date": "1992-03-14",
    "address": "123 Main St",
    "city": "Bangalore",
    "state": "Karnataka",
    "pincode": "560001",
    "pan": "ABCDE1234F",
    "gst": null,
    "customer_type": "Individual",
    "occupation": "Engineer",
    "annual_income": 1200000.0,
    "marital_status": "Married",
    "education": "Graduate",
    "nominees": {
      "life_insurance_nominees": [
        {
          "policy_number": "LIC-2026-0011",
          "policy_type": "life_insurance",
          "nominee_name": "John Doe",
          "relationship": "Spouse",
          "age": 36,
          "share_percentage": 100
        }
      ],
      "total_nominees_count": 1
    }
  }
}
```

Field notes:
- `city`/`state` vs. `city_id`/`state_id` depends on which columns the user model actually has (`respond_to?(:city)` vs `respond_to?(:city_id)`).
- `SubAgent` responses additionally include `role_id`, `pan` (from `pan_no`), `gst` (from `gst_no`), resolved `city`/`state` names (via a small hardcoded id→name lookup table — only ids 1–6 are mapped, others resolve to `null`), `account_type`, `account_holder_name`, `account_number` (from `account_no`), `ifsc_code`, `bank_name`, `upi_id`, `status`, `company_name`.
- `User` (agent) responses additionally include `user_type`, `role`, `pan_number`, `occupation`, `annual_income`.
- `nominees` is only present for `Customer` (pulled from every `LifeInsurance` policy's nominees, not policy-scoped).

No error responses (no failure branch in this action beyond the shared auth table).

---

### PUT /settings/profile

Updates the current user's profile. Permitted params depend on user type.

#### Request params (all optional; sent as top-level params, not nested under a root key)

| Param | Applies to | Notes |
|---|---|---|
| `first_name`, `last_name`, `mobile`, `gender`, `birth_date`, `address` | all | base fields |
| `city`, `state` | users with a `city` column | |
| `city_id`, `state_id` | users with a `city_id` column instead | |
| `pincode`, `occupation`, `annual_income`, `marital_status`, `education` | `Customer` only | |
| `gst_no`, `account_type`, `account_holder_name`, `account_no`, `ifsc_code`, `bank_name`, `upi_id`, `company_name` | `SubAgent` only | |
| `occupation`, `annual_income` | `User` (agent) only | |
| `nominees` | `Customer` only | Array; see below |

`nominees` array items (each requires `policy_number` to match an existing `LifeInsurance` of the current customer, else silently skipped):

| Field | Type |
|---|---|
| `policy_number` | string (required to locate the policy) |
| `nominee_name` | string (used to find-or-create the nominee record) |
| `relationship` | string |
| `age` | integer |
| `share_percentage` | number |

Note: nominee updates are best-effort — `nominee.save! if nominee.valid?` means an **invalid** nominee is silently skipped with no error surfaced to the client.

#### Response `200`

```json
{
  "success": true,
  "message": "Profile updated successfully",
  "data": { "...": "same shape as GET /settings/profile" }
}
```

#### Response `422` — validation failure on the user record

```json
{
  "success": false,
  "message": "Failed to update profile",
  "errors": ["Mobile is not a valid number"]
}
```

#### Response `422` — unexpected error (caught generically)

```json
{
  "success": false,
  "message": "Failed to update profile",
  "errors": ["<exception message>"]
}
```

---

### POST /settings/change_password

#### Request body

| Field | Type | Required | Notes |
|---|---|---|---|
| `new_password` | string | Yes | Min length 6 |
| `old_password` | string | No | Verified against current password if present |
| `current_password` | string | No | Alias for `old_password` (either works; `old_password` takes precedence if both sent) |

Behavior differs by resolved user type:
- **`SubAgent`** (has `password_digest`): verifies `old_password` via `authenticate` if provided, then sets a new `password_digest` and syncs `plain_password`; also pushes the same new password to the matching `User` record (by email), if one exists.
- **`User`** (agent, Devise): verifies `old_password` via `valid_password?` if provided, then saves the new password (validations skipped) and syncs `plain_password`.
- **`Customer`**: has no password of its own — looks up the linked `User` by email and changes *that* record's password/`plain_password` instead (validations skipped). Fails with 404 if no linked `User` exists.
- Any other user type: unsupported.

#### Response `200`

```json
{ "success": true, "message": "Password changed successfully" }
```

#### Error responses

| Condition | Status | Body |
|---|---|---|
| `new_password` blank | 422 | `{ "success": false, "message": "New password is required" }` |
| `new_password` shorter than 6 chars | 422 | `{ "success": false, "message": "Password must be at least 6 characters long" }` |
| No authenticated user (defensive; unreachable in practice since `authenticate_customer!` already guarantees one) | 404 | `{ "success": false, "message": "User not found" }` |
| `old_password` provided but incorrect | 422 | `{ "success": false, "message": "Current password is incorrect" }` |
| `Customer` has no linked `User` account | 404 | `{ "success": false, "message": "User account not found for this customer" }` |
| Save fails during the DB transaction | 422 | `{ "success": false, "message": "Failed to update password: <exception message>" }` |
| `Customer`'s linked `User` save fails validation | 422 | `{ "success": false, "message": "<joined validation errors>" }` |
| User type not `Customer`/`User`/`SubAgent`-with-password | 422 | `{ "success": false, "message": "Password change not supported for this user type" }` |

---

### GET /settings/terms

Returns static Terms & Conditions content plus a URL.

No params.

#### Response `200`

```json
{
  "success": true,
  "data": {
    "terms_url": "https://api.example.com/terms_and_conditions.html",
    "terms_content": "Terms and Conditions for DemoFarm Admin\n\n1. General Terms\n..."
  }
}
```

`terms_content` is a hardcoded multi-line string in the controller (not stored in the DB); `terms_url` is built from `request.base_url` and points at a static asset that isn't part of this API surface.

No error responses.

---

### GET /settings/contact

Returns support/contact info; shape depends on the caller's role.

No params.

#### Response `200` — `Customer` role

```json
{
  "success": true,
  "data": {
    "agent_name": "Atma Nirbhar Farm Support Team",
    "agent_mobile": "+918431174477",
    "agent_email": "support@dr-wise.in",
    "agent_address": "123 Insurance Street, Mumbai, Maharashtra, India",
    "company_info": {
      "name": "Atma Nirbhar Farm",
      "mobile": "+918431174477",
      "email": "support@dhanvantarifarm.in",
      "address": "123 Insurance Street, Mumbai, Maharashtra, India",
      "website": "www.dhanvantarifarm.in"
    },
    "support_hours": "Monday to Friday: 9:00 AM - 6:00 PM",
    "emergency_contact": "+918431174477"
  }
}
```

`agent_*` fields come from the `sub_agent` on the customer's first `LifeInsurance` policy (via a join), if one exists; otherwise a hardcoded default support-team block is used (note: its `agent_email` — `support@dr-wise.in` — is a different domain than `company_info.email`).

#### Response `200` — `User`/`SubAgent` (agent) role

```json
{
  "success": true,
  "data": {
    "company_name": "Atma Nirbhar Farm",
    "support_mobile": "+918431174477",
    "support_email": "support@dhanvantarifarm.in",
    "support_address": "123 Insurance Street, Mumbai, Maharashtra, India",
    "website": "www.dhanvantarifarm.in",
    "support_hours": "Monday to Friday: 9:00 AM - 6:00 PM",
    "emergency_contact": "+918431174477",
    "technical_support": { "mobile": "+918431174477", "email": "support@dhanvantarifarm.in" },
    "sales_support": { "mobile": "+918431174477", "email": "support@dhanvantarifarm.in" }
  }
}
```

#### Response `401` — unrecognized role (defensive; unreachable in practice)

```json
{ "success": false, "message": "Invalid user role" }
```

---

### POST /settings/helpdesk

Creates a support ticket (`ClientRequest`). Not tied to the caller's identity beyond auth being required — the submitted contact fields are used, not the logged-in user's profile.

#### Request body

| Field | Type | Required |
|---|---|---|
| `name` | string | Yes |
| `email` | string | Yes |
| `phone_number` | string | No |
| `description` | string | Yes |

#### Response `200`

```json
{
  "success": true,
  "message": "Your request has been submitted successfully. Our team will contact you soon.",
  "data": {
    "request_id": 88,
    "ticket_number": "TCK-2026-0088",
    "status": "pending",
    "estimated_response_time": "24-48 hours"
  }
}
```

`priority` is always created as `"medium"` (not client-settable).

#### Error responses

| Condition | Status | Body |
|---|---|---|
| `name`, `email`, or `description` blank | 422 | `{ "success": false, "message": "Name, email, and description are required" }` |
| `ClientRequest` fails model validation | 422 | `{ "success": false, "message": "Failed to submit request", "errors": ["..."] }` |

---

## Banners

Promotional banners for the mobile app home/dashboard/login/sidebar screens. Backed by `Api::V1::Mobile::BannersController` — **no `before_action :authenticate_customer!`** is set, so all four endpoints are public and do not require an `Authorization` header.

Base URL prefix: `/api/v1/mobile`

All success/error bodies use the shared `render_success`/`render_error` helpers from `BaseController` (`{ success, message, data }` / `{ success: false, message, errors? }`).

---

### GET /banners

Returns all currently active banners, ordered for display. Result is cached (`Rails.cache`, key `MobileApiCache.banners_key('all')`, TTL `MobileApiCache::BANNER_TTL`).

No query params are actually read (a `banner_params` private method permits `:location`, but `index` never calls it or filters by location — likely dead/unfinished code; the `Banner.by_location` scope exists on the model but isn't used here).

#### Response `200`

```json
{
  "success": true,
  "message": "Banners fetched successfully",
  "data": {
    "banners": [
      {
        "id": 7,
        "title": "Monsoon Sale",
        "description": "Up to 30% off",
        "redirect_link": "https://example.com/sale",
        "display_location": "home",
        "display_order": 1,
        "image_url": "https://.../rails/active_storage/blobs/...",
        "display_start_date": "2026-08-01",
        "display_end_date": "2026-09-01",
        "is_active": true,
        "created_at": "2026-08-01 09:00:00"
      }
    ],
    "total_count": 1
  }
}
```

`banners` scope is `Banner.active.current.ordered` — i.e. `status: true` AND today between `display_start_date`/`display_end_date`, ordered by `display_order, created_at`.

#### Response `500` — unexpected error

```json
{ "success": false, "message": "Failed to fetch banners" }
```

---

### GET /banners/locations

Returns the valid `display_location` enum values, for populating a location filter/picker client-side.

No params.

#### Response `200`

```json
{
  "success": true,
  "message": "Banner locations fetched successfully",
  "data": [
    { "key": "dashboard", "value": "dashboard", "display_name": "Dashboard" },
    { "key": "login", "value": "login", "display_name": "Login" },
    { "key": "home", "value": "home", "display_name": "Home" },
    { "key": "sidebar", "value": "sidebar", "display_name": "Sidebar" }
  ]
}
```

`display_name` is `key.humanize` (no i18n).

#### Response `500` — unexpected error

```json
{ "success": false, "message": "Failed to fetch banner locations" }
```

---

### GET /banners/:id

Returns details for one banner. Only returns banners that are both `active` (`status: true`) and currently within their display window (`current?`) — an inactive-but-existing, or active-but-outside-date-range, banner is reported as not found rather than as "inactive".

#### Path params

| Param | Type | Notes |
|---|---|---|
| `id` | integer | Banner id |

#### Response `200`

```json
{
  "success": true,
  "message": "Banner details fetched successfully",
  "data": {
    "id": 7,
    "title": "Monsoon Sale",
    "description": "Up to 30% off",
    "redirect_link": "https://example.com/sale",
    "display_location": "home",
    "display_location_text": "Home",
    "display_order": 1,
    "image_url": "https://.../rails/active_storage/blobs/...",
    "display_start_date": "2026-08-01",
    "display_end_date": "2026-09-01",
    "is_active": true,
    "is_current": true,
    "is_expired": false,
    "is_upcoming": false,
    "created_at": "2026-08-01 09:00:00",
    "updated_at": "2026-08-01 09:00:00"
  }
}
```

#### Error responses

| Condition | Status | Body |
|---|---|---|
| Banner id doesn't exist, or `status: false` (i.e. `Banner.active.find` raises `RecordNotFound`) | 404 | `{ "success": false, "message": "Banner not found" }` |
| Banner exists and is `active` but outside its display window (`current?` false) | 404 | `{ "success": false, "message": "Banner is not currently active" }` |
| Unexpected error | 500 | `{ "success": false, "message": "Failed to fetch banner details" }` |

---

### POST /banners/:id/track_click

Records a click (currently just a log line — no counter/analytics table is written) and hands back the banner's redirect link for the app to navigate to.

#### Path params

| Param | Type | Notes |
|---|---|---|
| `id` | integer | Banner id |

No body params.

Note: unlike `GET /banners/:id`, this only checks `Banner.active` (`status: true`) — it does **not** check `current?`, so a click can be tracked (and a redirect link returned) for a banner that's active but currently outside its display date window.

#### Response `200`

```json
{
  "success": true,
  "message": "Banner click tracked successfully",
  "data": { "redirect_link": "https://example.com/sale" }
}
```

#### Error responses

| Condition | Status | Body |
|---|---|---|
| Banner id doesn't exist, or `status: false` | 404 | `{ "success": false, "message": "Banner not found" }` |
| Unexpected error | 500 | `{ "success": false, "message": "Failed to track banner click" }` |
## Delivery Person

Endpoints used by the delivery-person mobile app to view assigned work for the day and update delivery progress.

Base path: `/api/v1/mobile/delivery`

A "task" is either:

- A **booking** (`Booking` record, `type: "order"`) — a regular ecommerce order out for delivery.
- A **subscription delivery** (`MilkDeliveryTask` record, `type: "subscription"`) — a recurring milk-subscription drop.

Both share the same `/tasks/*` endpoints; the controller looks at the id and tries `Booking` first, then `MilkDeliveryTask`.

### Authentication

```
Authorization: Bearer <jwt_token>
```

Obtained from `POST /api/v1/mobile/auth/login` with a delivery-person account (response includes `role: "delivery_person"` and `delivery_person_id`).

`DeliveryController` does **not** use the shared `Api::V1::Mobile::BaseController#authenticate_customer!` convention (`role` + `user_id` claims) used elsewhere in the mobile API. It has its own `authenticate_delivery_person!`, which:

1. Decodes the JWT with `Rails.application.secret_key_base` / `HS256`.
2. Reads the `delivery_person_id` claim directly (it does **not** check a `role` claim).
3. Loads `DeliveryPerson.find_by(id: delivery_person_id)`.

Any token — regardless of `role` — that carries a `delivery_person_id` claim resolving to a real `DeliveryPerson` row is accepted.

| Condition | Status | Body |
|---|---|---|
| Missing/invalid/expired token, or `delivery_person_id` doesn't resolve | 401 | `{ "success": false, "message": "Unauthorized: Invalid or expired token" }` |

Note: this is a single generic message for every auth failure mode (no separate "token missing" vs "account not found" distinction like the customer/agent flows have).

### Authorization caveat (not enforced)

Only `GET /delivery/tasks/today` scopes results to the caller's own `delivery_person_id`. `GET /delivery/tasks/:id`, `start`, `complete`, and `update_location` look the task up by id alone (`Booking.find_by(id: …)` / `MilkDeliveryTask.find_by(id: …)`) with **no check that the task is assigned to the authenticated delivery person**. Any authenticated delivery person can view or mutate any booking/subscription task by id. The two bulk endpoints also accept an optional `delivery_person_id` in the body that overrides the caller's own id with no ownership check.

---

### GET /delivery/tasks/today

Returns today's assigned bookings and subscription deliveries for the authenticated delivery person, plus a summary and a (stubbed) route suggestion.

- Bookings: `delivery_person_id = current`, `created_at` is today, status not in `delivered`/`cancelled`.
- Subscription tasks: `delivery_person_id = current`, `delivery_date` is today (all statuses, including completed).

### Response `200`

```json
{
  "success": true,
  "data": {
    "summary": {
      "total_tasks": 5,
      "completed": 1,
      "pending": 4,
      "failed": 0,
      "total_collection": 850.0
    },
    "tasks": [
      {
        "id": 4521,
        "type": "order",
        "order_number": "BK20260823A1B2C3",
        "customer": {
          "name": "Ravi Kumar",
          "mobile": "9876543210",
          "address": "12 MG Road",
          "landmark": null,
          "pincode": "560001",
          "latitude": null,
          "longitude": null
        },
        "items": [
          { "product_name": "Toned Milk 1L", "quantity": 2, "unit": "piece" }
        ],
        "payment": {
          "method": "cash",
          "amount_to_collect": 200.0,
          "status": "unpaid"
        },
        "delivery_slot": "10:00 AM - 12:00 PM",
        "priority": "normal",
        "status": "pending",
        "special_instructions": null
      },
      {
        "id": 88,
        "type": "subscription",
        "order_number": "SUB-88",
        "customer": {
          "name": "Anita Rao",
          "mobile": "9123456780",
          "address": "44 Church Street",
          "pincode": null,
          "latitude": null,
          "longitude": null
        },
        "items": [
          { "product_name": "Cow Milk 500ml", "quantity": 1, "unit": "packet" }
        ],
        "payment": { "method": "prepaid", "amount_to_collect": 0, "status": "paid" },
        "delivery_slot": "07:00 AM - 09:00 AM",
        "priority": "normal",
        "status": "assigned",
        "special_instructions": null
      }
    ],
    "route_optimization": {
      "suggested_sequence": [4521, 88, 4530],
      "estimated_completion_time": "75 minutes",
      "total_distance": "10 km"
    }
  }
}
```

- `status` for a booking task is remapped: `ordered_and_delivery_pending → pending`, `out_for_delivery → in_progress`, `delivered → completed` (any other booking status passes through unchanged). A subscription task's `status` is its raw `MilkDeliveryTask` enum value (`pending`, `assigned`, `delivered`, `completed`, `cancelled`, `missed`, `paused`).
- `total_collection` in `summary` sums `total_amount` only for booking tasks with `payment_method == "cash"`; subscriptions are always prepaid and excluded.
- `route_optimization` is a stub: `suggested_sequence` is just the first 3 task ids in query order (no real routing), and `estimated_completion_time` / `total_distance` are `tasks.count * 15 minutes` / `tasks.count * 2 km`.

### Response `500`

```json
{ "success": false, "message": "<exception message>" }
```

---

### GET /delivery/tasks/:id

Fetch full details for one task (booking or subscription). Same object shape as an item in `tasks_today`'s `tasks` array. **Not scoped to the caller** — see authorization caveat above.

### Response `200`

```json
{ "success": true, "data": { "task": { "id": 4521, "type": "order", "...": "..." } } }
```

### Errors

| Condition | Status | Body |
|---|---|---|
| No `Booking` or `MilkDeliveryTask` with this id | 404 | `{ "success": false, "message": "Task not found" }` |
| Unhandled exception | 500 | `{ "success": false, "message": "<exception message>" }` |

---

### POST /delivery/tasks/:id/start

Marks a task as started. Takes no required body.

### Behavior

- Booking task: status is **hard-set to `out_for_delivery`**, regardless of its current status (no validation that the current status is a sane predecessor — e.g. a `draft` or `delivered` booking can be pushed back to `out_for_delivery`).
- Subscription task: status is **hard-set to `assigned`** the same way.

### Response `200`

```json
{
  "success": true,
  "message": "Delivery started",
  "data": {
    "task_id": 4521,
    "status": "in_progress",
    "started_at": "2026-08-23T11:02:10+05:30",
    "estimated_arrival": "11:17 AM"
  }
}
```

`status` in the response body is always the literal string `"in_progress"` — it does not re-read the persisted status. `estimated_arrival` is a stub: always "now + 15 minutes", not based on location or route data.

### Errors

| Condition | Status | Body |
|---|---|---|
| Task not found | 404 | `{ "success": false, "message": "Task not found" }` |
| `update` fails (e.g. model validation error) | 422 | `{ "success": false, "message": "Failed to start delivery" }` |
| Unhandled exception | 500 | `{ "success": false, "message": "<exception message>" }` |

---

### POST /delivery/tasks/:id/complete

Marks a task as delivered/completed and optionally records a COD collection.

### Body params

| Param | Type | Required | Notes |
|---|---|---|---|
| `notes` | string | No | Stored as `delivery_notes` (booking tasks only). |
| `payment_collected[amount]` | number | No | Presence (not the value) drives whether `payment_status` flips to `paid`. Booking tasks only. |

No `params.require`/`params.permit` is used — params are read ad hoc via `params.dig(:notes)` / `params.dig(:payment_collected, :amount)`.

### Behavior

- Booking task: `status → "delivered"`, `delivered_at → now`, `delivery_notes → notes`. `payment_status → "paid"` **only if** `payment_collected[amount]` was present in the request, otherwise the booking's existing `payment_status` is left as-is (it is not necessarily `"paid"` even for a cash delivery unless the client sends `payment_collected`). If `payment_collected[amount]` is present, `record_payment` is called but is an **empty stub** — no `WalletTransaction`/payment record is actually created.
- Subscription task: `status → "completed"`, `completed_at → now`. `notes`/`payment_collected` are ignored for subscriptions.
- Both branches run in a DB transaction; on any exception the whole update rolls back and the endpoint returns 422 (the exception itself is only logged server-side, not returned to the client).

### Response `200`

```json
{
  "success": true,
  "message": "Delivery completed successfully",
  "data": {
    "task_id": 4521,
    "status": "completed",
    "completed_at": "2026-08-23T11:30:05+05:30",
    "payment_status": "collected",
    "next_task_id": 4530
  }
}
```

`payment_status` in the response is always the fixed literal `"collected"` — it does not reflect the booking's actual `payment_status` column (which may still be `unpaid`/`partially_paid` per the rule above). Clients should not treat this field as authoritative. `next_task_id` is the id of the delivery person's next pending booking for today (checked first), falling back to the next pending subscription task; `null` if none.

### Errors

| Condition | Status | Body |
|---|---|---|
| Task not found | 404 | `{ "success": false, "message": "Task not found" }` |
| Update raises inside the transaction | 422 | `{ "success": false, "message": "Failed to complete delivery" }` |
| Unhandled exception outside the transaction | 500 | `{ "success": false, "message": "<exception message>" }` |

---

### POST /delivery/tasks/:id/update_location

Intended to report the delivery person's live GPS position and get distance/ETA to the customer for one task.

### Body params

| Param | Type | Required |
|---|---|---|
| `latitude` | number | Not validated — `nil` is accepted |
| `longitude` | number | Not validated — `nil` is accepted |

### Behavior — currently a stub

- `update_delivery_location(lat, lng)` always returns `true` and **does not persist the location anywhere** (comment in code: "This could be stored in Redis or a location tracking table" — not implemented).
- `calculate_distance_to_customer` does **not** compute a real distance: it returns a hardcoded `500` (meters) if the task responds to `latitude`/`longitude`, else `1000`. It ignores the `latitude`/`longitude` params entirely.
- `estimated_arrival` = `(distance / 100).round` minutes, derived from the fake distance above.

### Response `200`

```json
{
  "success": true,
  "message": "Location updated",
  "data": {
    "distance_to_customer": "500 meters",
    "estimated_arrival": "5 minutes"
  }
}
```

### Errors

| Condition | Status | Body |
|---|---|---|
| Task not found | 404 | `{ "success": false, "message": "Task not found" }` |
| Unhandled exception | 500 | `{ "success": false, "message": "<exception message>" }` |

(422 "Failed to update location" is dead code — `update_delivery_location` always returns `true`, so this branch is unreachable today.)

---

### POST /delivery/bulk_mark_done

Marks a batch of tasks (bookings and/or subscription tasks, mixed) as delivered/completed in one call — no location or payment detail per item, just a flat list of ids.

### Body params

| Param | Type | Required | Notes |
|---|---|---|---|
| `delivery_ids` | array of integers | Yes | Coerced with `.to_i`, deduped. |
| `delivery_person_id` | integer | No | Defaults to the caller's own id. **Overrides it with no ownership check if supplied.** |
| `completed_at` | datetime | No | Defaults to `Time.current`. Applied to whichever record type matched. |

### Behavior

For each id: looked up first against `Booking`, then `MilkDeliveryTask` (both batch-loaded up front).

- Booking found, not already `delivered` → `status: "delivered"`, `delivered_at`, `delivery_person_id` set; id added to `updated_delivery_ids`.
- Booking found, already `delivered` → error `"Already completed"`.
- No booking; `MilkDeliveryTask` found, not already `completed` → `status: "completed"`, `completed_at`, `delivery_person_id` set.
- `MilkDeliveryTask` found, already `completed` → error `"Already completed"`.
- Neither found → error `"Delivery not found"`.
- Any raised exception for one id (e.g. a validation error from `update!`) is caught per-item and reported, without aborting the rest of the batch.

### Response `200` — at least one succeeded

```json
{
  "success": true,
  "message": "2 of 3 deliveries marked as done",
  "data": {
    "updated_count": 2,
    "updated_delivery_ids": [4521, 88],
    "failed_ids": [9999],
    "errors": [{ "id": 9999, "error": "Delivery not found" }]
  }
}
```

`failed_ids` and `errors` are omitted from `data` entirely when empty (via `.compact`/`.presence`).

### Response `422` — none succeeded

```json
{
  "success": false,
  "message": "Failed to update deliveries",
  "data": {
    "updated_count": 0,
    "failed_ids": [4521, 88],
    "errors": [
      { "id": 4521, "error": "Already completed" },
      { "id": 88, "error": "Already completed" }
    ]
  }
}
```

### Other errors

| Condition | Status | Body |
|---|---|---|
| `delivery_ids` missing or not an array | 400 | `{ "success": false, "message": "No delivery IDs provided" }` |
| Unhandled exception | 500 | `{ "success": false, "message": "Internal server error while processing bulk update", "error": "<exception message, only in development>" }` |

---

### POST /delivery/bulk_update

Marks a batch of **bookings only** (not subscription tasks) as delivered or failed, with richer per-item detail (notes, GPS, failure reason).

### Body params

| Param | Type | Required | Notes |
|---|---|---|---|
| `delivery_person_id` | integer | No | Defaults to the caller's own id. Overrides it with no ownership check if supplied. |
| `updates` | array of objects | Yes | See fields below. |

Each object in `updates`:

| Field | Type | Required | Applies when |
|---|---|---|---|
| `booking_id` | integer | Yes | always |
| `status` | string (`"delivered"` \| `"failed"`) | Yes | always — anything else → `"Invalid status"` error for that item |
| `delivered_at` | datetime | No (defaults to now) | `status: "delivered"` |
| `delivery_notes` | string | No | `status: "delivered"` |
| `latitude` / `longitude` | number | No | `status: "delivered"` |
| `attempted_at` | datetime | No (defaults to now) | `status: "failed"` |
| `failure_reason` | string | No | `status: "failed"` |

### Behavior and a known bug

- `status: "delivered"` → `booking.update(status: "delivered", delivered_at:, delivery_notes:, delivery_person_id:, latitude:, longitude:)`.
- `status: "failed"` → `booking.update(status: "failed_delivery", failed_at:, failure_reason:, delivery_person_id:)`. **`"failed_delivery"` is not a member of `Booking`'s `status` enum** (valid values: `draft`, `ordered_and_delivery_pending`, `confirmed`, `processing`, `packed`, `shipped`, `out_for_delivery`, `delivered`, `completed`, `cancelled`, `returned`). Assigning an invalid enum value raises `ArgumentError` immediately on `update`. Unlike `bulk_mark_done`, this inner loop has **no per-item rescue**, so that `ArgumentError` propagates straight to the controller's top-level `rescue`, aborting the *entire* batch with a 500 — any items already updated earlier in the loop stay committed (no transaction wraps the loop), but the response gives the client no indication which ones. In practice, sending any `status: "failed"` item today breaks the whole request.
- Booking id not found → per-item error `"Booking not found"`.
- `booking.update` validation failure (non-enum) → per-item error, the model's `errors.full_messages.join(", ")`.

### Response `200`

Always `success: true` at the top level, even if some/all individual items failed — check `failed_updates` / each item's `status`.

```json
{
  "success": true,
  "message": "1 deliveries updated successfully",
  "data": {
    "total_processed": 2,
    "successful_updates": 1,
    "failed_updates": 1,
    "results": [
      {
        "booking_id": 4521,
        "status": "success",
        "message": "Delivery marked as completed",
        "booking_number": "BK20260823A1B2C3"
      },
      {
        "booking_id": 9999,
        "status": "error",
        "message": "Booking not found"
      }
    ],
    "summary": {
      "delivered_count": 1,
      "failed_count": 0,
      "pending_count": 0
    }
  }
}
```

`summary.pending_count` is always `0` (not computed from anything). `summary.failed_count` only increments for successfully-persisted `status: "failed"` items — which, per the bug above, currently can't succeed.

### Other errors

| Condition | Status | Body |
|---|---|---|
| `updates` missing or not an array | 400 | `{ "success": false, "message": "No updates provided" }` |
| Unhandled exception (incl. the enum bug above) | 500 | `{ "success": false, "message": "Failed to process bulk updates", "error": "<exception message, only in development>" }` |

---

### Notes for client implementation

- Treat `payment_status: "collected"` in the `complete_task` response and `status: "in_progress"` in the `start_task` response as fixed labels, not live reads of the record — re-fetch `GET /delivery/tasks/:id` if you need the authoritative state.
- `update_location` does not currently persist anything server-side and its distance/ETA are hardcoded placeholders — do not build live-tracking UI on top of it as-is.
- Avoid `bulk_update` with `status: "failed"` until the `"failed_delivery"` enum mismatch is fixed server-side; use `bulk_mark_done`/`complete_task` for the "delivered" path in the meantime, or catch the 500 and treat the whole batch as unresolved.
- `GET /delivery/tasks/today` is the only endpoint scoped to the caller; all other single-task and bulk endpoints will act on any task id / delivery_person_id supplied, so don't rely on server-side ownership checks client-side.
## Agent Dashboard, Leads & Commission

Covers the agent-facing mobile endpoints: dashboard stats, customer management, form metadata, the insurance-company directory, leads, and commission distribution/summary.

Base URL prefix: `/api/v1/mobile/agent`

Controller: `Api::V1::Mobile::AgentController` (`app/controllers/api/v1/mobile/agent_controller.rb`)

### Authentication

```
Authorization: Bearer <jwt_token>
```

Obtained from the agent/sub-agent login endpoints. Every action in this section runs `authenticate_agent!` (distinct from the customer-facing `authenticate_customer!` used elsewhere in the mobile API), which requires the JWT's `role` claim to be **`agent`** or **`sub_agent`** — no other role is accepted, including `customer` or an admin-issued token with a different role string. A `User` record whose `user_type` is `admin` but that authenticates with `role: "agent"` is still let in and is treated as an admin for data-scoping purposes (see per-endpoint notes on admin vs. agent vs. sub-agent visibility below).

| Condition | Status | Body |
|---|---|---|
| Missing header | 401 | `{ "success": false, "message": "Authorization token is required" }` |
| Token role is neither `agent` nor `sub_agent` | 401 | `{ "success": false, "message": "Agent authorization required" }` |
| Malformed/invalid JWT | 401 | `{ "success": false, "message": "Invalid authorization token" }` |
| Token valid, `User`/`SubAgent` record not found | 401 | `{ "success": false, "message": "Agent not found" }` |

Three visibility tiers recur across these endpoints, determined by helper methods on the controller:

- **Admin** — a `User` with `user_type == 'admin'` (`is_admin?`). Sees all data system-wide.
- **Sub-agent** — a `SubAgent` record, or a `User` with `user_type == 'sub_agent'`, or a `User` whose email/mobile matches an existing `SubAgent` (`is_sub_agent?`). Scoped to policies/customers/leads tied to that sub-agent.
- **Agent** — any other authenticated `User`. Scoped via `get_agent_policies`, which resolves policies through a matching `SubAgent` (by email) if one exists, otherwise falls back to treating the `User`'s own id as the `sub_agent_id`.

---

### GET /agent/dashboard

Summary statistics + recent activity for the logged-in agent/sub-agent/admin.

### Query params

None.

### Response `200`

```json
{
  "success": true,
  "data": {
    "agent_info": {
      "name": "Ravi Kumar",
      "email": "ravi@example.com",
      "mobile": "9876543210",
      "role": "sub_agent"
    },
    "statistics": {
      "customers_count": 42,
      "policies_count": 58,
      "life_policies_count": 58,
      "total_premium": 1250000.0,
      "total_sum_insured": 45000000.0,
      "commission_earned": 87500.0,
      "this_month_policies": 6,
      "this_month_premium": 120000.0,
      "this_month_customers": 3,
      "policy_distribution": {
        "life": { "count": 58, "percentage": 100.0 }
      },
      "performance_metrics": {
        "conversion_rate": 34.5,
        "commission_this_month": 9500.0,
        "target_achievement": 0
      }
    },
    "recent_activities": [
      {
        "type": "policy_created",
        "message": "Life insurance policy LI2026000123 created for Anita Sharma",
        "timestamp": "2026-08-22T14:03:11+05:30",
        "policy_type": "Life"
      }
    ]
  }
}
```

`statistics` and `agent_info.role` (falls back to `'sub_agent'` when the user has no `Role` association) shift shape by tier:

| Tier | Extra fields | Notes |
|---|---|---|
| Admin | `active_customers`, `inactive_customers`, `motor_policies_count`, `policy_distribution.motor` | System-wide totals |
| Sub-agent | `total_sum_insured`, `this_month_customers`, `performance_metrics.conversion_rate`/`commission_this_month`/`target_achievement` | Scoped to the sub-agent's own `LifeInsurance` rows |
| Agent | (base fields only) | No `performance_metrics`/`total_sum_insured` |

`recent_activities` is always the 10 most recent `LifeInsurance` policies (scoped by tier), regardless of role — only life-insurance activity is surfaced; there is no motor/other activity feed.

### Error responses

Only the shared auth failures above (401). No feature flags or additional guards.

---

### GET /agent/customers

Paginated customer list, scoped by tier, with policy counts/premium and an optional add-source filter.

### Query params

| Param | Type | Default | Notes |
|---|---|---|---|
| `page` | integer | `1` | |
| `per_page` | integer | `10` | No hard cap enforced in code |
| `filter` | string | none | `agent_added` (added via this mobile API), `system_added` (everything else), or omitted/`all` for no filter |

### Response `200`

```json
{
  "success": true,
  "data": {
    "customers": [
      {
        "id": 101,
        "name": "Anita Sharma",
        "mobile": "9876543210",
        "email": "anita@example.com",
        "password": "anita3210123",
        "customer_type": "individual",
        "status": "Active",
        "policies_count": 2,
        "total_premium": 45000.0,
        "added_by": "agent_mobile_api_7",
        "added_via": "mobile_api",
        "created_at": "2026-07-01T09:12:00+05:30",
        "profile_image": "https://dr-wise-ag.onrender.com/rails/active_storage/...",
        "attached_documents": [
          {
            "id": 5,
            "document_type": "id_proof",
            "filename": "aadhar.pdf",
            "file_size": 204800,
            "file_type": "application/pdf",
            "uploaded_at": "2026-07-01T09:15:00+05:30",
            "download_url": "https://dr-wise-ag.onrender.com/rails/active_storage/..."
          }
        ]
      }
    ],
    "statistics": {
      "total_customers": 42,
      "agent_added_customers": 10,
      "system_added_customers": 32,
      "my_added_customers": 4
    },
    "pagination": {
      "current_page": 1,
      "per_page": 10,
      "total_customers": 42,
      "total_pages": 5
    }
  }
}
```

`policies_count`/`total_premium` are computed only from `LifeInsurance` records (grouped/batched per page, not per-row queries). `my_added_customers` is always `0` for admins.

**Note (worth flagging to the mobile team):** every customer row includes a plaintext `password` field — a deterministic "demo password" derived as `first_name.downcase + last_4_digits_of_mobile + "123"` (see `generate_demo_password`). It is not the customer's real account password, but it is a predictable string reconstructable from public-ish data (name + phone) and is returned to any authenticated agent/sub-agent for every customer in scope. Flag this to whoever owns the security review of this doc.

### Error responses

Only the shared auth failures above (401).

---

### POST /agent/customers

Creates a `Customer` (and an associated `User` login) attributed to the calling agent/sub-agent.

### Request params (`params.permit`)

| Param | Type | Required | Notes |
|---|---|---|---|
| `first_name` | string | Yes | |
| `last_name` | string | No | |
| `company_name` | string | No | |
| `mobile` | string | Yes | Must match `^[6-9]\d{9}$` after stripping non-digits |
| `email` | string | Yes | Must match `URI::MailTo::EMAIL_REGEXP` |
| `customer_type` | string | No | |
| `gender` | string | No | Lower-cased before save |
| `birth_date` | string | No | |
| `address`, `city`, `state`, `pincode` | string | No | |
| `pan_no`, `gst_no` | string | No | |
| `occupation`, `annual_income`, `marital_status` | — | No | `marital_status` lower-cased before save |
| `image_url` | string | No | |
| `password`, `password_confirmation` | string | No | Auto-generated (matching, random) if both omitted; if provided, must match, be ≥8 chars, and contain upper+lower+digit+special char |
| `file1`, `file2` | file | No | Uploaded via `handle_customer_file_uploads`, failures are swallowed and reported in `files.upload_errors` |
| `documents` | array of `{document_type, document_file}` | No | Handled best-effort; failures are logged, not returned |

### Response `201`

```json
{
  "status": true,
  "message": "Customer created successfully",
  "data": {
    "customer_id": 205,
    "name": "Anita Sharma",
    "email": "anita@example.com",
    "mobile": "9876543210",
    "customer_type": "individual",
    "gender": "female",
    "birth_date": "1990-05-12",
    "address": "12 MG Road",
    "city": "Bengaluru",
    "state": "Karnataka",
    "pincode": "560001",
    "pan_no": "ABCDE1234F",
    "occupation": "Engineer",
    "annual_income": "1200000",
    "marital_status": "married",
    "files": { "file1": null, "file2": null, "upload_status": "success" },
    "user_account": { "...": "created User info" },
    "added_by": "agent_mobile_api_7",
    "added_by_agent": { "id": 7, "name": "Ravi Kumar", "email": "ravi@example.com" },
    "created_at": "2026-08-23 10:00:00",
    "password_info": {
      "auto_generated": true,
      "password": "aB3$kLp9",
      "message": "Password was auto-generated since none was provided"
    }
  }
}
```

Note the top-level envelope here uses `status` (boolean), not `success`, unlike most other agent endpoints — a client that only checks `success` on this response will always read it as falsy/undefined.

### Error responses

| Condition | Status | Body |
|---|---|---|
| Existing customer with same email or mobile | 409 | `{ "status": false, "message": "Customer with this email or mobile already exists", "error": "duplicate_customer", "data": { "customer_id": ..., "name": ..., "...": "existing customer's fields" } }` |
| Validation failure (missing/invalid name, mobile, email, password rules, existing `User` with same email) | 422 | `{ "status": false, "message": "Validation failed", "errors": ["Mobile number is required", "..."] }` |
| `Customer.save` fails model validation (e.g. DB-level constraint) | 422 | `{ "status": false, "message": "Failed to create customer", "errors": ["..."] }` |

`affiliate_id`/`sub_agent_id` on the new customer is set to the calling `SubAgent`'s id directly (if caller is a `SubAgent`), or to a matching `SubAgent` found by email (if caller is a `User`) — otherwise left `nil`.

---

### GET /agent/form_data

Static/semi-static dropdown data for building the agent app's create-policy / create-lead / create-customer forms. No params, no pagination.

### Response `200`

```json
{
  "success": true,
  "data": {
    "clients": [ { "id": 101, "name": "Anita Sharma", "email": "anita@example.com", "mobile": "9876543210" } ],
    "insurance_companies": [ { "id": 1, "name": "LIC of India" } ],
    "payment_modes": ["monthly", "quarterly", "half_yearly", "yearly", "single"],
    "policy_types": ["individual", "family", "group"],
    "insurance_types": ["health", "life", "motor", "other"],
    "policy_holder_options": ["self", "other"],
    "relationships": ["self", "spouse", "child", "father", "mother", "brother", "sister"],
    "document_types": ["policy_copy", "proposal_form", "medical_reports", "id_proof", "address_proof"],
    "lead_stages": [ { "value": "consultation", "label": "Consultation" }, "..." ],
    "lead_sources": [ { "value": "online", "label": "Online" }, "..." ],
    "product_interests": [ { "value": "health", "label": "Health Insurance" }, "..." ],
    "priority_levels": [ { "value": "high", "label": "High" }, "..." ],
    "states": ["Andhra Pradesh", "..."],
    "customer_types": ["individual", "corporate"],
    "genders": ["Male", "Female", "Other"],
    "marital_statuses": ["Single", "Married", "Divorced", "Widowed"],
    "vehicle_types": ["Two Wheeler", "Four Wheeler", "Commercial Vehicle"],
    "coverage_types": ["Property", "Travel", "Personal Accident", "Fire", "Marine", "Cyber Security", "Other"],
    "commission_periods": [ { "value": "all", "label": "All Time" }, "..." ],
    "commission_policy_types": [ { "value": "all", "label": "All Policy Types" }, { "value": "health", "label": "Health Insurance" }, { "value": "life", "label": "Life Insurance" }, { "value": "motor", "label": "Motor Insurance" } ],
    "commission_status": [ { "value": "all", "label": "All Status" }, { "value": "paid", "label": "Paid" }, { "value": "pending", "label": "Pending" } ]
  }
}
```

**Important — verified against current code, not assumed:** `insurance_types`, `product_interests`, and `commission_policy_types` all still list **`health`** as an option, even though the `HealthInsurance` model was fully removed from the codebase (2026-08-17). This is dropdown/form metadata only — it is not backed by a live model check, so it wasn't updated by the removal. There is no `agent/*` endpoint left in this controller to actually create a health policy (only `add_life_policy`, `add_motor_policy`, `add_other_policy` exist — no `add_health_policy`), and `commission_distribution`/`commission_summary` (below) never populate a `health` bucket. A client that lets the user pick "Health Insurance" from this dropdown and then tries to act on it has nowhere to submit it. `clients` is capped at the 100 most-recently-active customers (not the full list, not scoped to the calling agent). `insurance_companies` here is a hardcoded 8-company static list (see next endpoint for the real, DB-backed company directory) — id values are just a 1-based index into that static array, not real `InsuranceCompany` ids.

### Error responses

Only the shared auth failures (401).

---

### GET /agent/insurance_companies

Real, DB-backed insurance company directory (`InsuranceCompany` model) — distinct from the static list embedded in `form_data` above.

### Query params

| Param | Type | Default | Notes |
|---|---|---|---|
| `page` | integer | `1` | |
| `per_page` | integer | `20` | |
| `search` | string | none | Matches `name` or `code`, case-insensitive (`ILIKE`) |
| `status` | string | none | `active`, `inactive`, or omitted/`all` |

### Response `200`

```json
{
  "success": true,
  "data": {
    "insurance_companies": [
      {
        "id": 3,
        "name": "HDFC ERGO General Insurance Co Ltd",
        "code": "HDFCERGO",
        "status": "Active",
        "contact_person": "Support Desk",
        "email": "support@hdfcergo.com",
        "mobile": "1800XXXXXXX",
        "address": "Mumbai, MH",
        "created_at": "2026-01-10 12:00:00",
        "updated_at": "2026-01-10 12:00:00"
      }
    ],
    "statistics": {
      "total_companies": 34,
      "active_companies": 34,
      "inactive_companies": 0
    },
    "pagination": {
      "current_page": 1,
      "per_page": 20,
      "total_companies": 34,
      "total_pages": 2
    }
  }
}
```

`statistics` are global counts across all `InsuranceCompany` rows regardless of the applied `search`/`status` filters (they don't reflect the filtered result set). The `InsuranceCompany` model has no `type`/category column exposed here, so there's no way to tell health vs. life vs. general from this response — that distinction only exists in a separate `InsuranceCompanyConstants` static list used elsewhere, not surfaced by this endpoint.

### Error responses

Only the shared auth failures (401).

---

### GET /agent/leads

Paginated lead list with stage/product/search filtering, plus lead statistics.

### Query params

| Param | Type | Default | Notes |
|---|---|---|---|
| `page` | integer | `1` | |
| `per_page` | integer | `10` | |
| `stage` | string | none | Passed to `Lead.by_stage` |
| `product` | string | none | Passed to `Lead.by_product` |
| `search` | string | none | Passed to `Lead.search_leads` (pg_search) |

No agent-scoping is applied — the comment in code is explicit: *"agents can see all leads for now"*. Every authenticated agent/sub-agent sees every `Lead` in the system, filters aside.

### Response `200`

```json
{
  "success": true,
  "data": {
    "leads": [
      {
        "id": 88,
        "lead_id": "LD20260820001",
        "name": "Suresh Rao",
        "contact_number": "9812345678",
        "email": "suresh@example.com",
        "product_interest": "Life",
        "current_stage": "Consultation scheduled",
        "lead_source": "Agent referral",
        "created_date": "2026-08-20",
        "full_address": "..., Bengaluru, Karnataka",
        "referred_by": null,
        "stage_progress": 20,
        "stage_description": "...",
        "can_advance": true,
        "can_go_back": false,
        "next_stage": "one_on_one",
        "previous_stage": null,
        "converted_customer_id": null,
        "policy_created_id": null,
        "referral_amount": 0.0,
        "transferred_amount": false,
        "stage_badge_class": "badge-info",
        "source_badge_class": "badge-secondary",
        "product_badge_class": "badge-primary",
        "created_at": "2026-08-20 11:22:00"
      }
    ],
    "statistics": {
      "total_leads": 240,
      "this_month_leads": 18,
      "pending_leads": 12,
      "converted_leads": 55,
      "conversion_rate": 22.92,
      "by_stage": { "consultation": 10, "one_on_one": 4, "converted": 55, "policy_created": 40, "referral_settled": 6 },
      "by_product": { "health": 30, "life": 120, "motor": 40, "home": 5, "travel": 2, "other": 43 },
      "by_source": { "online": 20, "offline": 15, "agent_referral": 100, "walk_in": 30, "tele_calling": 40, "other": 35 }
    },
    "pagination": {
      "current_page": 1,
      "per_page": 10,
      "total_leads": 240,
      "total_pages": 24
    }
  }
}
```

`statistics` is always computed globally (all leads, unfiltered), independent of the `stage`/`product`/`search` params applied to the `leads` list — same pattern as `insurance_companies`' statistics block. `by_product` still tracks a `health` bucket (leads are independent of the insurance-policy models, so this isn't affected by the `HealthInsurance` removal — a "health" lead just has nowhere to convert into a policy).

### Error responses

Only the shared auth failures (401).

---

### POST /agent/leads

Creates a `Lead`, attributed to the calling agent/sub-agent as its affiliate when applicable.

### Request params (`params.permit`)

| Param | Type | Required | Notes |
|---|---|---|---|
| `name` | string | Yes | Split on whitespace into `first_name`/`last_name` (first token / remainder; defaults `"Customer"`/`"Name"` if unparseable) |
| `contact_number` | string | Yes | Must match `^[6-9]\d{9}$` (after stripping non-digits) or `^\+91[6-9]\d{9}$` |
| `email` | string | No | Must match `URI::MailTo::EMAIL_REGEXP` if present |
| `product_interest` | string | No | Default `'health'`; mapped to `product_category: 'insurance'` and a `product_subcategory` (`health`→`health`, `life`→`life`, `motor`→`motor`, `home`→`general`, `travel`→`travel`, else `other`) |
| `address`, `city`, `state` | string | No | |
| `referred_by` | string | No | |
| `current_stage` | string | No | Default `'lead_generated'` |
| `created_date` | string | No | Parsed via `parse_date`; default `Date.current` |
| `note` | string | No | Stored as `notes` |
| `call_disposition` | string | No | |
| `lead_source` | string | No | Default `'agent_referral'` |
| `referral_amount` | number | No | Default `0.0` |
| `transferred_amount` | boolean | No | Default `false` |
| `priority` | string | No | Permitted but not currently persisted anywhere on `Lead` |

### Response `201`

```json
{
  "status": true,
  "message": "Lead created successfully",
  "data": {
    "lead_id": "LD20260823002",
    "id": 241,
    "name": "Suresh Rao",
    "contact_number": "9812345678",
    "email": "suresh@example.com",
    "product_interest": "life",
    "product_category": "insurance",
    "product_subcategory": "life",
    "customer_type": "individual",
    "current_stage": "lead_generated",
    "lead_source": "agent_referral",
    "created_at": "2026-08-23 10:05:00",
    "stage_progress": 0,
    "can_advance": true,
    "next_stage": "consultation_scheduled",
    "full_address": "..., Bengaluru, Karnataka",
    "referral_type": "...",
    "affiliate_info": { "affiliate_id": 7, "affiliate_name": "Ravi Kumar", "is_direct": false },
    "created_by": { "agent_id": 12, "agent_name": "Ravi Kumar", "agent_type": "SubAgent" }
  }
}
```

Same envelope quirk as `POST /agent/customers`: top level is `status` (boolean), not `success`.

`affiliate_id`/`is_direct` logic: if the caller is a `SubAgent`, they become the lead's affiliate directly (`is_direct: false`). If the caller is a `User` with `user_type == 'agent'`, the controller looks for a `SubAgent` with a matching email and uses that as the affiliate if found; otherwise the lead is `is_direct: true` with no affiliate. Admin users creating a lead (no matching `SubAgent`) always get `is_direct: true`.

### Error responses

| Condition | Status | Body |
|---|---|---|
| Missing `name`/`contact_number`, bad phone/email format, duplicate `contact_number` or `email` (checked against any existing `Lead`, not scoped to caller) | 422 | `{ "status": false, "message": "Validation failed", "errors": ["A lead with contact number 9812345678 already exists (Lead ID: LD20260810003)", "..."] }` |
| `Lead.save` fails model validation | 422 | `{ "status": false, "message": "Failed to create lead", "errors": ["..."] }` |

---

### GET /agent/commission_distribution

Paginated list of individual `CommissionPayout` rows for sub-agent-level commissions, plus aggregate statistics.

### Query params

| Param | Type | Default | Notes |
|---|---|---|---|
| `page` | integer | `1` | |
| `per_page` | integer | `10` | |
| `period` | string | none | `this_month`, `last_month`, `this_year`, or omitted/`all` — filters on `payout_date` |
| `policy_type` | string | none | Filters `CommissionPayout.policy_type`; omitted/`all` = no filter |

Base scope is always `CommissionPayout.where(payout_to: 'sub_agent')` — this endpoint only ever shows sub-agent-tier commission, regardless of whether the caller is an agent, sub-agent, or admin. If the caller is a sub-agent, results are further restricted to payouts whose `policy_id` is one of that sub-agent's own `LifeInsurance` policies (`policy_type = 'life'` only — motor/other payouts aren't policy-scoped for sub-agents since there's no sub-agent-owned motor/other policy table to join against). Admins and plain agents see **all** sub-agent commission payouts, unfiltered by ownership.

### Response `200`

```json
{
  "success": true,
  "data": {
    "commissions": [
      {
        "id": 900,
        "policy_type": "Life",
        "policy_id": 512,
        "policy_number": "N/A",
        "customer_name": "N/A",
        "payout_amount": 2500.0,
        "payout_date": "2026-08-15",
        "status": "Paid",
        "created_at": "2026-08-15 09:30:00"
      }
    ],
    "statistics": {
      "total_commissions": 34,
      "total_amount": 85000.0,
      "paid_amount": 60000.0,
      "pending_amount": 25000.0,
      "paid_count": 20,
      "pending_count": 14,
      "by_policy_type": {
        "life": { "count": 30, "amount": 75000.0 },
        "motor": { "count": 4, "amount": 10000.0 }
      }
    },
    "pagination": {
      "current_page": 1,
      "per_page": 10,
      "total_commissions": 34,
      "total_pages": 4
    }
  }
}
```

**Notable current-code behavior worth flagging:** `policy_number` and `customer_name` are hardcoded to `"N/A"` in every row, always. `CommissionPayout#policy` (`app/models/commission_payout.rb`) was changed to unconditionally return `nil` — its own comment says *"No insurance policy types remain... so there's nothing to look up"* — but that's stale/inaccurate: `LifeInsurance` is still a live model, actively queried elsewhere in this same controller. The `preload_policies` batching call in `commission_distribution` (`CommissionPayout.preload_policies(commission_payouts.to_a)`) primes every payout's `@policy` to `nil` rather than actually loading the underlying `LifeInsurance` row, so `payout&.policy` is dead — the `policy_number`/`customer_name` fallback branches (`policy&.policy_number || 'N/A'`) always take the `'N/A'` path. `policy_id`/`policy_type` themselves are still correct (read directly off the `CommissionPayout` row), just not resolved into the underlying policy's details. Treat this as a known gap, not something to "fix" by inference in the docs — it's what the endpoint actually returns today.

Numbers represent: **`payout_amount`** is the commission amount owed/paid to the sub-agent for that one policy; **`status`** is `pending`/`processing`/`paid`/`cancelled` (from the `CommissionPayout` enum); the `statistics` block sums/counts across the full filtered scope (not just the current page).

### Error responses

Only the shared auth failures (401).

---

### GET /agent/commission_summary

Aggregate earnings summary (no list, no pagination) — total/paid/pending, this-month/last-month, broken down by policy type.

### Query params

None.

### Response `200`

```json
{
  "success": true,
  "data": {
    "total_earnings": 87500.0,
    "paid_earnings": 60000.0,
    "pending_earnings": 27500.0,
    "this_month_earnings": 9500.0,
    "last_month_earnings": 12000.0,
    "by_policy_type": {
      "life": { "total": 87500.0, "paid": 60000.0, "pending": 27500.0 },
      "motor": { "total": 0.0, "paid": 0.0, "pending": 0.0 }
    }
  }
}
```

Computation differs by caller tier:

- **Sub-agent**: `total_earnings`/`by_policy_type.life.total` come straight from `LifeInsurance.sum(:sub_agent_after_tds_value)` across the sub-agent's own policies — i.e. the *entitled* commission amount on the policy record itself, independent of whether a `CommissionPayout` row exists yet. `paid_earnings` (and `this_month_earnings`/`last_month_earnings`, which are *always* the paid amount for that period, not total) come from summing actual `paid` `CommissionPayout` rows for those same policy ids. `pending_earnings` is simply `total_earnings - paid_earnings` (a derived gap, not a query against `pending`-status payouts). `by_policy_type.motor` is always zero for a sub-agent — there's no motor-commission source wired in for this tier.
- **Agent/admin**: everything is computed from `CommissionPayout.where(payout_to: 'sub_agent')` grouped by `(policy_type, status)` — i.e. system-wide sub-agent commission payouts, not scoped to the calling agent at all (same "always sub-agent-tier, unscoped for agents/admins" pattern as `commission_distribution`). Here `pending_earnings` *is* the actual sum of `pending`-status payouts (not a subtraction), so the sub-agent and agent/admin branches compute `pending_earnings` differently even though the field name is the same.

`by_policy_type` only ever has `life` and `motor` keys — there is no `health` or `other` bucket in either branch, despite `form_data` still advertising `health` as a commission policy type filter option.

### Error responses

Only the shared auth failures (401).

---

### Implementation notes

- All 9 endpoints share one auth gate (`authenticate_agent!`) — role must decode to `agent` or `sub_agent`; there is no separate "admin-only" auth tier at the controller level. Admin-vs-agent-vs-sub-agent behavior is entirely driven by looking at the resolved `User`/`SubAgent` record's type inside each action, not by the JWT role itself.
- Two different success envelopes are in use: most `GET` endpoints use `{ success: true, data: {...} }`; both `POST` endpoints (`add_customer`, `add_lead`) use `{ status: true, message: ..., data: {...} }`. Clients must branch on which key to check per endpoint.
- `commission_distribution` and `commission_summary` only ever report **sub-agent-tier** commission (`payout_to: 'sub_agent'`). There is no endpoint here for an agent's own (non-sub-agent) commission payouts.
- `health` still appears throughout dropdown/filter metadata (`form_data`, lead `product_interest`/`by_product`) because `Lead` and form dropdowns are independent of the insurance-policy models — but there is no way to create a health *policy* or see health-policy commission through this controller; only `life`, `motor`, and `other` policy-creation endpoints (`add_life_policy`, `add_motor_policy`, `add_other_policy`) exist.
---

## Known Issues Found While Documenting This API

These surfaced incidentally while tracing each endpoint's actual code path — not a security
audit, just what was visible in the course of documenting behavior. Worth triaging separately;
listed here so they aren't lost, not as a demand to fix them as part of this doc.

### Auth / access control

- **`POST /auth/login` — sub-agent branch has no password check.** The direct-`SubAgent` login
  path only requires `status == 'active'`; anyone who knows a sub-agent's email/mobile can get a
  valid token for them (when no `User`/`Customer`/`DeliveryPerson` account matches first).
- **`authenticate_customer!` accepts `agent`/`sub_agent` tokens too**, despite the name — it isn't
  customer-exclusive. Combined with the next point, this is a real crash path.
- **Customer Portfolio actions (`portfolio`, `upcoming_installments`, `upcoming_renewals`) call
  `current_customer.id` with no nil guard.** A valid `agent`/`sub_agent` token passes auth (per
  above) and then 500s inside the action instead of a clean 4xx.
- **Delivery-person auth doesn't use the shared `role`-based guard.** `DeliveryController`
  extends `ApplicationController` directly with its own `authenticate_delivery_person!` that
  trusts a bare `delivery_person_id` JWT claim and never checks `role`.
- **No ownership enforcement on most delivery-person endpoints.** Only `tasks_today` scopes to
  the caller's `delivery_person_id`. `tasks/:id`, `start`, `complete`, `update_location`, and
  both bulk endpoints (which accept an overridable `delivery_person_id` body param) let any
  authenticated delivery person act on any task/booking.
- **`register` with `role: "sub_agent"` silently creates a plain `agent`-type `User`** (no
  `SubAgent` row), and the response always reports `role: "agent"` regardless of what was
  requested.

### Data correctness

- **`CommissionPayout#policy` unconditionally returns `nil`**, so `commission_distribution`'s
  `policy_number`/`customer_name` fields are hardcoded `"N/A"` in every row. The code comment
  claims "no insurance policy types remain," which is inaccurate — `LifeInsurance` is still live
  and used elsewhere in the same controller.
- **`login`'s `User`-agent branch returns deterministic mock commission/dashboard stats**, not
  real figures — easy to mistake for live data if not flagged.
- **`GET /agent/customers` returns a predictable plaintext "demo password"** per customer
  (`first_name + last4(mobile) + "123"`) — not the real account password, but derivable from
  public-ish data, so still worth a second look.
- **`product_details`'s `delivery_info` block is a hardcoded placeholder** ("All India", "3-5
  business days"), not derived from real delivery rules.
- **`featured_products` is just "newest products"**, not a curated/flagged featured set —
  misleading name.
- **`customer_type` in the profile response is a hardcoded `"individual"` literal**; no backing
  column exists.
- **Three unrelated delivery-checking systems coexist and can disagree**: per-product
  `DeliveryRule`s, the global pincode-keyed `DeliveryCharge` table, and an external India Post
  API lookup for district/state/serviceability.
- **Inconsistent status-code semantics across delivery-check endpoints.** `check_delivery`,
  `check_delivery_by_pincode`, `check_pincode`, and `delivery/validate` all return HTTP 200 even
  when the result is "not deliverable"/"invalid pincode" (clients must inspect the body). Only
  `delivery/charges` uses 422 for an unserviceable pincode — inconsistent with its siblings.
- **"Subscriptions" means `MilkSubscription` specifically**, not a generic subscription model.
  A `format_subscription_data` helper describing a differently-shaped object exists in the
  controller but is dead code — never called by any route.
- **`create_subscription` silently drops accepted-but-unused params**: `delivery_address`,
  `latitude`/`longitude`, `notes` are permitted but never passed into `MilkSubscription.new`.
- **`pause_subscription`/`resume_subscription`/`cancel_subscription` only flip the `status`
  column** — they don't call the model's own `pause_all_tasks!`/`resume_all_tasks!`, so
  already-generated delivery tasks aren't touched.
- **`reset_password`'s "token expired" error branch appears to be dead code** — the lookup query
  already excludes tokens older than 24h before that check runs.
- **Vestigial `health` references remain in dropdown/summary metadata** even though
  HealthInsurance was fully removed from the codebase: `agent/form_data`'s
  `insurance_types`/`product_interests`/`commission_policy_types` still list `health` with no
  backing feature, and `upcoming_renewals`'s `by_insurance_type` summary always reports
  `health: 0`.
- **Dead `banner_params` in `BannersController#index`** permits `:location` but is never used —
  `GET /banners` doesn't actually support the location filtering its model layer (`by_location`
  scope) would allow.
- **`GET /banners/:id` vs `POST /banners/:id/track_click` apply different activeness checks** —
  `show` requires both `active` and currently-in-date-range; `track_click` only requires
  `active`, so a click can be tracked for a banner outside its display window even though `show`
  would 404 it.

### Bugs (likely to actually break in production)

- **`POST delivery/bulk_update` with `status: "failed"` crashes the whole batch.** It sets
  `Booking#status = "failed_delivery"`, which is not a valid value in the `Booking` status enum
  (only `draft`…`returned`) — raises `ArgumentError`, isn't rescued per-item (unlike
  `bulk_mark_done`), and 500s the entire request instead of just that item.
- **`update_location` is a non-functional stub** — it doesn't persist location anywhere, and
  "distance to customer" in its response is a hardcoded 500m/1000m, not a real calculation.
- Several delivery-person response fields are fixed literals rather than live state (e.g.
  `complete_task`'s `payment_status: "collected"`, `start_task`'s `status: "in_progress"`), and
  `record_payment` for COD collection is an empty no-op — no payment record is actually created.
- **Nominee updates via `PUT /settings/profile` fail silently.** Invalid nominee data is dropped
  via `save! if valid?` with no error surfaced to the client — the request looks like it
  succeeded either way.
- **`change_password` for a `Customer` doesn't touch the `Customer` record** — it updates the
  linked `User` record's password by email lookup, since `Customer` has no password column of
  its own. Not a bug per se, but a surprising indirection worth knowing before debugging a
  "password didn't change" report.
