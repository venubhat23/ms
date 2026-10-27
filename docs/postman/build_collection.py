#!/usr/bin/env python3
"""
Generates docs/postman/Ecommerce_Store_MS_Mobile_API.postman_collection.json
from the documented shape of the Mobile API (docs/MOBILE_API.md +
docs/CUSTOMER_WALLET_API.md). Re-run this script (not hand-edit the JSON)
whenever the docs change.
"""
import json
import uuid

def uid():
    return str(uuid.uuid4())

def url(path, query=None):
    # path like "ecommerce/products" -> {{base_url}}/api/v1/mobile/ecommerce/products
    raw = "{{base_url}}/api/v1/mobile/" + path.lstrip("/")
    u = {
        "raw": raw + (("?" + "&".join(f"{q['key']}={q.get('value','')}" for q in query)) if query else ""),
        "host": ["{{base_url}}"],
        "path": ["api", "v1", "mobile"] + [p for p in path.split("/") if p != ""],
    }
    if query:
        u["query"] = query
    return u

def qp(key, value="", description="", disabled=False):
    d = {"key": key, "value": str(value), "description": description}
    if disabled:
        d["disabled"] = True
    return d

def body_raw(obj):
    return {
        "mode": "raw",
        "raw": json.dumps(obj, indent=2),
        "options": {"raw": {"language": "json"}},
    }

def req(name, method, path, query=None, body=None, auth=None, description="", tests=None, header=None):
    item = {
        "name": name,
        "request": {
            "method": method,
            "header": header or [],
            "url": url(path, query),
            "description": description,
        },
        "response": [],
    }
    if body is not None:
        item["request"]["body"] = body_raw(body)
    if auth == "noauth":
        item["request"]["auth"] = {"type": "noauth"}
    elif auth is not None:
        item["request"]["auth"] = auth
    if tests:
        item["event"] = [{
            "listen": "test",
            "script": {"type": "text/javascript", "exec": tests.split("\n")},
        }]
    return item

def bearer(var):
    return {"type": "bearer", "bearer": [{"key": "token", "value": "{{" + var + "}}", "type": "string"}]}

CUSTOMER = bearer("token")
AGENT = bearer("agent_token")
DELIVERY = bearer("delivery_token")

LOGIN_TEST = """\
if (pm.response.code === 200) {
    const json = pm.response.json();
    if (json.success && json.data && json.data.token) {
        const role = json.data.role;
        pm.collectionVariables.set('token', json.data.token);
        if (role === 'agent' || role === 'sub_agent') {
            pm.collectionVariables.set('agent_token', json.data.token);
        }
        if (role === 'delivery_person') {
            pm.collectionVariables.set('delivery_token', json.data.token);
        }
        if (json.data.customer_id) {
            pm.collectionVariables.set('customer_id', json.data.customer_id);
        }
        pm.test('Login returned a token', () => pm.expect(json.data.token).to.be.a('string'));
    }
}
"""

OTP_VERIFY_TEST = """\
if (pm.response.code === 200) {
    const json = pm.response.json();
    if (json.success && json.data && json.data.token) {
        pm.collectionVariables.set('token', json.data.token);
        pm.collectionVariables.set('customer_id', json.data.customer_id);
        pm.test('OTP verify returned a token', () => pm.expect(json.data.token).to.be.a('string'));
    }
}
"""

# ---------------------------------------------------------------------------
# 1. Authentication
# ---------------------------------------------------------------------------
authentication = [
    req("Login (Customer)", "POST", "auth/login", auth="noauth",
        body={"email": "asha@example.com", "password": "password123"},
        description="Tries User, Customer, DeliveryPerson, then SubAgent tables in order. "
                     "Response shape (and which role-specific fields appear) depends on which "
                     "account type matched. Auto-saves `token`/`customer_id` on success.",
        tests=LOGIN_TEST),
    req("Login (Agent / Sub-agent)", "POST", "auth/login", auth="noauth",
        body={"email": "ravi@example.com", "password": "password123"},
        description="Same endpoint as customer login — the account type is resolved server-side. "
                     "Note: a direct SubAgent-table match does NOT check password at all (see docs). "
                     "Auto-saves `agent_token` on success.",
        tests=LOGIN_TEST),
    req("Login (Delivery Person)", "POST", "auth/login", auth="noauth",
        body={"mobile": "9123456780", "password": "password123"},
        description="Same endpoint; matches the DeliveryPerson table. Auto-saves `delivery_token` on success.",
        tests=LOGIN_TEST),
    req("Register (Customer)", "POST", "auth/register", auth="noauth",
        body={
            "role": "customer",
            "first_name": "Asha",
            "last_name": "Rao",
            "email": "new.customer@example.com",
            "mobile": "9876543210",
            "password": "password123",
            "password_confirmation": "password123",
            "address": "12 MG Road",
            "city": "Bengaluru",
            "state": "Karnataka",
            "pincode": "560001",
        },
        description="Creates a Customer + paired User row. Does NOT return a JWT — call "
                     "POST /auth/login afterward."),
    req("Register (Agent)", "POST", "auth/register", auth="noauth",
        body={
            "role": "agent",
            "first_name": "Ravi",
            "last_name": "Kumar",
            "email": "new.agent@example.com",
            "mobile": "9876500001",
            "password": "password123",
            "password_confirmation": "password123",
            "pan_no": "ABCDE1234F",
        },
        description="Creates a User with status:false (pending admin approval) — cannot log in "
                     "until an admin activates the account."),
    req("Forgot Password", "POST", "auth/forgot_password", auth="noauth",
        body={"email": "asha@example.com"},
        description="Sends a password-reset email to a Customer account (case-insensitive email match). "
                     "Reset token is valid 24 hours."),
    req("Reset Password", "POST", "auth/reset_password", auth="noauth",
        body={
            "token": "{{reset_token}}",
            "password": "newPassword123",
            "password_confirmation": "newPassword123",
        },
        description="Completes the reset using the token from the email link."),
    req("Request OTP", "POST", "auth/otp/request", auth="noauth",
        body={"mobile": "9876543210"},
        description="Sends a 6-digit SMS OTP (MSG91), valid 5 minutes, 60s resend cooldown, "
                     "max 5 requests/hour. Gated by SystemSetting.otp_login_enabled?."),
    req("Verify OTP", "POST", "auth/otp/verify", auth="noauth",
        body={"mobile": "9876543210", "otp": "123456"},
        description="Verifies the OTP and logs in (creating a minimal User+Customer pair on first-ever "
                     "login for that mobile). Auto-saves `token`/`customer_id` on success.",
        tests=OTP_VERIFY_TEST),
]

# ---------------------------------------------------------------------------
# 2. E-commerce — Catalog & Search
# ---------------------------------------------------------------------------
catalog = [
    req("Get Categories", "GET", "ecommerce/categories", auth=CUSTOMER,
        description="Returns all active categories. Cached."),
    req("Get Category Details", "GET", "ecommerce/categories/{{category_id}}", auth=CUSTOMER,
        description="404 if category not found."),
    req("Get Category Products", "GET", "ecommerce/categories/{{category_id}}/products",
        query=[qp("page", 1), qp("per_page", 20), qp("min_price", "", "optional"),
               qp("max_price", "", "optional"), qp("search", "", "optional"),
               qp("sort_by", "name", "price_low|price_high|name|newest|rating")],
        auth=CUSTOMER,
        description="Paginated product listing scoped to one category (active + available_for_sale only)."),
    req("Get Products", "GET", "ecommerce/products",
        query=[qp("page", 1), qp("per_page", 20), qp("category_id", "", "optional"),
               qp("min_price", "", "optional"), qp("max_price", "", "optional"),
               qp("search", "", "optional"),
               qp("sort_by", "", "price_low|price_high|name|newest|rating (default: stock availability)")],
        auth="noauth",
        description="PUBLIC — no auth required. Paginated, filterable, cached product listing."),
    req("Get Product Details", "GET", "ecommerce/products/{{product_id}}", auth=CUSTOMER,
        description="Auth required (despite the list endpoint being public). Includes related_products, "
                     "reviews, and a static delivery_info placeholder — use check_delivery for a real answer."),
    req("Get Featured Products", "GET", "ecommerce/featured_products",
        query=[qp("limit", 5, "capped at 10")],
        auth="noauth",
        description="PUBLIC. Despite the name, this is simply the newest products, not a curated flag."),
    req("Search Products", "GET", "ecommerce/search",
        query=[qp("query", "milk"), qp("page", 1), qp("per_page", 20),
               qp("category_id", "", "optional"), qp("min_price", "", "optional"),
               qp("max_price", "", "optional"),
               qp("sort_by", "", "price_low|price_high|name|newest|rating")],
        auth=CUSTOMER,
        description="One of query/q/search is required — 400 if all are absent."),
    req("Get Filters", "GET", "ecommerce/filters", auth=CUSTOMER,
        description="Returns filter facets (categories, price_range, brands, sort_options) for building "
                     "the product listing UI. Cached."),
    req("Get Banners (Ecommerce)", "GET", "ecommerce/banners",
        query=[qp("location", "home")],
        auth="noauth",
        description="PUBLIC. Distinct from the standalone /banners module below — same underlying model, "
                     "different response shape. Cached per location."),
]

# ---------------------------------------------------------------------------
# 3. E-commerce — Delivery Validation & Location
# ---------------------------------------------------------------------------
delivery_validation = [
    req("Check Product Delivery", "POST", "ecommerce/products/{{product_id}}/check_delivery",
        auth=CUSTOMER,
        body={"pincode": "560001"},
        description="Per-product DeliveryRule check. IMPORTANT: HTTP 200 + success:true even when NOT "
                     "deliverable — check data.deliverable, not the top-level success flag."),
    req("Check Delivery By Pincode", "POST", "ecommerce/check_delivery",
        auth=CUSTOMER,
        body={"pincode": "560001"},
        description="Global DeliveryCharge table lookup (not tied to any product). Also returns 200 + "
                     "success:true for a non-deliverable pincode — check data.deliverable."),
    req("Check Pincode (India Post)", "GET", "ecommerce/delivery/check-pincode/{{pincode}}",
        auth=CUSTOMER,
        description="Validates against the external api.postalpincode.in service (cached). Returns HTTP 200 "
                     "even when data.valid is false — check the payload, not the status code."),
    req("Validate Delivery (Multi-product)", "POST", "ecommerce/delivery/validate",
        auth=CUSTOMER,
        body={
            "pincode": "560001",
            "product_ids": ["{{product_id}}"],
            "delivery_date": "2026-09-10",
        },
        description="Validates pincode via India Post, then checks stock + DeliveryRule per product id. "
                     "success mirrors overall_delivery_available; still HTTP 200 on failure."),
    req("Get Delivery Charges", "POST", "ecommerce/delivery/charges",
        auth=CUSTOMER,
        body={"pincode": "560001", "address": "12 MG Road, Bengaluru"},
        description="Global DeliveryCharge lookup. Unlike the other delivery endpoints, this one DOES use "
                     "a real 422 for an unserviceable/invalid pincode."),
    req("Save Location", "POST", "ecommerce/location/save",
        auth=CUSTOMER,
        body={"latitude": 12.9716, "longitude": 77.5946, "address": "12 MG Road, Bangalore", "pincode": "560001"},
        description="Updates the authenticated customer's stored lat/long. Note: pincode is echoed back "
                     "only — Customer has no pincode column, it is not actually persisted."),
]

# ---------------------------------------------------------------------------
# 4. Customer Profile (Ecommerce controller's profile actions)
# ---------------------------------------------------------------------------
customer_profile = [
    req("Get Profile", "GET", "ecommerce/profile", auth=CUSTOMER,
        description="Customer resolved by email from the JWT. Includes statistics + last-5 recent "
                     "orders/bookings in basic form."),
    req("Update Profile", "PUT", "ecommerce/profile", auth=CUSTOMER,
        body={
            "first_name": "Asha",
            "last_name": "K",
            "mobile": "9876543210",
            "address": "12 MG Road, Bangalore",
            "gender": "female",
            "marital_status": "single",
            "birth_date": "1995-04-10",
            "occupation": "Engineer",
            "preferred_language": "en",
        },
        description="All fields optional; accepted top-level, or nested under `customer`/`ecommerce` "
                     "(checked in that order). Cannot change email/id."),
]

# ---------------------------------------------------------------------------
# 5. E-commerce — Bookings & Checkout
# ---------------------------------------------------------------------------
bookings = [
    req("Create Booking", "POST", "ecommerce/bookings", auth=CUSTOMER,
        body={
            "booking": {
                "customer_id": "{{customer_id}}",
                "delivery_address": "12 MG Road, Bengaluru",
                "pincode": "560001",
                "customer_name": "Jane Doe",
                "customer_email": "jane@example.com",
                "customer_phone": "9876543210",
                "payment_method": "cash",
                "notes": "",
                "use_wallet": False,
                "booking_items_attributes": [
                    {"product_id": "{{product_id}}", "quantity": 2, "price": 100.0}
                ],
            }
        },
        description="Validates every product exists first (422 with unavailable_products if not) but "
                     "allows booking past available stock. Set booking[use_wallet]=true to pay from the "
                     "customer wallet first — see CUSTOMER_WALLET_API.md."),
    req("List Bookings", "GET", "ecommerce/bookings",
        query=[qp("page", 1), qp("per_page", 20), qp("status", "", "optional exact status filter")],
        auth=CUSTOMER,
        description="Customer resolved by email from JWT. Ordered most-recent-first."),
    req("Get Booking Payment Status", "GET", "ecommerce/bookings/{{booking_id}}/payment_status",
        auth=CUSTOMER,
        description="Lightweight polling endpoint for Cashfree payment status on one booking."),
    req("Cart Order Checkout", "POST", "ecommerce/checkout/cart_order", auth=CUSTOMER,
        body={
            "booking": {
                "booking_items_attributes": [
                    {"product_id": "{{product_id}}", "quantity": 2, "price": 100.0}
                ],
                "payment_method": "cod",
                "delivery_address": "12 MG Road, Bengaluru",
                "pincode": "560001",
            }
        },
        description="payment_method 'cod' confirms immediately; any other value opens a Cashfree payment "
                     "session (booking created as 'draft'). use_wallet is NOT supported on this endpoint."),
    req("Verify Payment", "POST", "ecommerce/verify_payment", auth=CUSTOMER,
        body={"booking_id": "{{booking_id}}"},
        description="Queries Cashfree directly and updates the booking if paid. Can return HTTP 200 with "
                     "success:false when payment isn't complete yet — check the body, not just the status."),
]

# ---------------------------------------------------------------------------
# 6. E-commerce — Orders
# ---------------------------------------------------------------------------
orders = [
    req("List Orders", "GET", "ecommerce/orders",
        query=[qp("page", 1), qp("per_page", 20), qp("status", "", "optional exact status filter")],
        auth=CUSTOMER,
        description="Order (distinct from Booking) records for the authenticated customer."),
    req("Get Order Details", "GET", "ecommerce/orders/{{order_id}}", auth=CUSTOMER,
        description="Scoped to customer.orders; 404 if not owned by this customer."),
]

# ---------------------------------------------------------------------------
# 7. E-commerce — Subscriptions (MilkSubscription)
# ---------------------------------------------------------------------------
subscriptions = [
    req("Create Subscription", "POST", "ecommerce/subscriptions", auth=CUSTOMER,
        body={
            "subscription": {
                "product_id": "{{product_id}}",
                "pincode": "560001",
                "quantity": 1,
                "frequency": "daily",
                "start_date": "2026-09-05",
                "end_date": "2026-09-30",
                "delivery_time": "morning",
            }
        },
        description="Recurring milk-delivery subscription (despite the generic route name, this is always "
                     "MilkSubscription). pincode is validated via the external India Post API — request "
                     "fails if unserviceable. Creating this synchronously generates one MilkDeliveryTask "
                     "per delivery date in range."),
    req("List Subscriptions", "GET", "ecommerce/subscriptions",
        query=[qp("page", 1), qp("per_page", 20), qp("status", "", "active|paused|expired|cancelled")],
        auth=CUSTOMER),
    req("Get Subscription Details", "GET", "ecommerce/subscriptions/{{subscription_id}}", auth=CUSTOMER,
        description="Includes the 10 most recent delivery tasks."),
    req("Pause Subscription", "PUT", "ecommerce/subscriptions/{{subscription_id}}/pause", auth=CUSTOMER,
        description="Only succeeds from status 'active'. Does NOT bulk-update already-generated delivery tasks."),
    req("Resume Subscription", "PUT", "ecommerce/subscriptions/{{subscription_id}}/resume", auth=CUSTOMER,
        description="Only succeeds from status 'paused'."),
    req("Cancel Subscription", "PUT", "ecommerce/subscriptions/{{subscription_id}}/cancel", auth=CUSTOMER,
        description="Succeeds from any status except already-'cancelled'."),
]

# ---------------------------------------------------------------------------
# 8. Customer Wallet
# ---------------------------------------------------------------------------
wallet = [
    req("Get Wallet Balance & History", "GET", "customer/wallet",
        query=[qp("page", 1), qp("per_page", 20, "capped at 50")],
        auth=CUSTOMER,
        description="Balance + paginated transaction history. Lazily creates a zero-balance wallet on "
                     "first call. 403 if SystemSetting.customer_wallet_enabled? is false. "
                     "See docs/CUSTOMER_WALLET_API.md — wallet payment itself happens via "
                     "POST ecommerce/bookings with booking[use_wallet]=true, not a separate endpoint."),
]

# ---------------------------------------------------------------------------
# 9. Customer Portfolio
# ---------------------------------------------------------------------------
portfolio = [
    req("Get Portfolio", "GET", "customer/portfolio", auth=CUSTOMER,
        description="All of the customer's Life + Motor insurance policies plus summary counts. "
                     "Customer-role tokens only — an agent/sub_agent token 500s here (see docs)."),
    req("Get Upcoming Installments", "GET", "customer/upcoming_installments", auth=CUSTOMER,
        description="Upcoming premium installments (next 60 days) for Life + Motor policies, plus "
                     "renewal-style installments for policies expired within the last 18 months."),
    req("Get Upcoming Renewals", "GET", "customer/upcoming_renewals", auth=CUSTOMER,
        description="Policies renewing within 2 months across Life, Motor, Travel, General, Other "
                     "(each only if its model is present)."),
]

# ---------------------------------------------------------------------------
# 10. Settings
# ---------------------------------------------------------------------------
settings = [
    req("Get Settings Profile", "GET", "settings/profile", auth=CUSTOMER,
        description="Field set depends on the authenticated user's type (Customer/User-agent/SubAgent). "
                     "Works with customer, agent, or sub_agent tokens."),
    req("Update Settings Profile", "PUT", "settings/profile", auth=CUSTOMER,
        body={
            "first_name": "Asha",
            "last_name": "K",
            "mobile": "9876543210",
            "address": "123 Main St",
        },
        description="Permitted params depend on user type — see docs. Params are top-level, not nested."),
    req("Change Password", "POST", "settings/change_password", auth=CUSTOMER,
        body={"old_password": "oldPassword123", "new_password": "newPassword123"},
        description="Behavior differs by resolved user type (Customer routes through its linked User; "
                     "SubAgent/User change their own password_digest)."),
    req("Get Terms & Conditions", "GET", "settings/terms", auth=CUSTOMER),
    req("Get Contact Info", "GET", "settings/contact", auth=CUSTOMER,
        description="Response shape depends on caller role (Customer vs. User/SubAgent)."),
    req("Submit Helpdesk Ticket", "POST", "settings/helpdesk", auth=CUSTOMER,
        body={
            "name": "Jane Doe",
            "email": "jane@example.com",
            "phone_number": "9876543210",
            "description": "I need help with my last order.",
        },
        description="Creates a ClientRequest ticket. priority is always 'medium', not client-settable."),
]

# ---------------------------------------------------------------------------
# 11. Banners (standalone module — all public)
# ---------------------------------------------------------------------------
banners = [
    req("List Banners", "GET", "banners", auth="noauth",
        description="PUBLIC. All currently-active banners, cached. No filtering params are actually read."),
    req("Get Banner Locations", "GET", "banners/locations", auth="noauth",
        description="PUBLIC. Valid display_location enum values for a location picker."),
    req("Get Banner Details", "GET", "banners/{{banner_id}}", auth="noauth",
        description="PUBLIC. 404 if the banner is inactive OR outside its display date window."),
    req("Track Banner Click", "POST", "banners/{{banner_id}}/track_click", auth="noauth",
        description="PUBLIC. Logs the click (no counter persisted) and returns the redirect_link. Only "
                     "checks Banner.active, not the date window."),
]

# ---------------------------------------------------------------------------
# 12. Delivery Person
# ---------------------------------------------------------------------------
delivery_person = [
    req("Get Today's Tasks", "GET", "delivery/tasks/today", auth=DELIVERY,
        description="Today's assigned bookings + subscription deliveries for the authenticated delivery "
                     "person. The ONLY delivery-person endpoint actually scoped to the caller's own id."),
    req("Get Task Details", "GET", "delivery/tasks/{{task_id}}", auth=DELIVERY,
        description="NOT scoped to the caller — any authenticated delivery person can view any task by id."),
    req("Start Task", "POST", "delivery/tasks/{{task_id}}/start", auth=DELIVERY,
        description="Hard-sets status to out_for_delivery (booking) / assigned (subscription) regardless "
                     "of current status — no predecessor-state validation."),
    req("Complete Task", "POST", "delivery/tasks/{{task_id}}/complete", auth=DELIVERY,
        body={"notes": "Delivered to security guard", "payment_collected": {"amount": 200.0}},
        description="payment_collected.amount presence (not its value) flips payment_status to paid for "
                     "booking tasks; omit it to leave payment_status unchanged."),
    req("Update Location", "POST", "delivery/tasks/{{task_id}}/update_location", auth=DELIVERY,
        body={"latitude": 12.9716, "longitude": 77.5946},
        description="Currently a stub server-side — location is not persisted; distance/ETA in the "
                     "response are hardcoded placeholders, not computed from these coordinates."),
    req("Bulk Mark Done", "POST", "delivery/bulk_mark_done", auth=DELIVERY,
        body={"delivery_ids": ["{{task_id}}"], "completed_at": "2026-09-02T11:30:00+05:30"},
        description="Marks a batch of bookings and/or subscription tasks as delivered/completed. "
                     "Per-item failures don't abort the rest of the batch."),
    req("Bulk Update", "POST", "delivery/bulk_update", auth=DELIVERY,
        body={
            "updates": [
                {
                    "booking_id": "{{task_id}}",
                    "status": "delivered",
                    "delivery_notes": "Left at gate",
                    "latitude": 12.9716,
                    "longitude": 77.5946,
                }
            ]
        },
        description="Bookings only (not subscription tasks). WARNING: status:'failed' currently raises an "
                     "invalid-enum error server-side ('failed_delivery' isn't a real Booking status) and "
                     "aborts the ENTIRE batch with a 500 — avoid sending status:'failed' until fixed; use "
                     "status:'delivered' or bulk_mark_done in the meantime."),
]

# ---------------------------------------------------------------------------
# 13. Agent Dashboard, Leads & Commission
# ---------------------------------------------------------------------------
agent = [
    req("Get Agent Dashboard", "GET", "agent/dashboard", auth=AGENT,
        description="Summary stats + recent activity. Response shape varies by tier (admin/sub-agent/agent)."),
    req("List Agent Customers", "GET", "agent/customers",
        query=[qp("page", 1), qp("per_page", 10),
               qp("filter", "", "agent_added|system_added|all (omit for no filter)")],
        auth=AGENT,
        description="NOTE: every row includes a plaintext demo `password` field derived from the "
                     "customer's name+mobile — flagged as a security concern in the docs, not a real "
                     "account password, but worth knowing before logging/displaying this response."),
    req("Add Agent Customer", "POST", "agent/customers", auth=AGENT,
        body={
            "first_name": "Anita",
            "last_name": "Sharma",
            "mobile": "9876543210",
            "email": "anita@example.com",
            "customer_type": "individual",
            "gender": "female",
            "address": "12 MG Road",
            "city": "Bengaluru",
            "state": "Karnataka",
            "pincode": "560001",
        },
        description="Creates a Customer + User login attributed to the calling agent/sub-agent. Response "
                     "envelope uses `status` (boolean), not `success` — different from most other agent "
                     "endpoints. Password is auto-generated if omitted (returned in password_info)."),
    req("Get Agent Form Data", "GET", "agent/form_data", auth=AGENT,
        description="Static dropdown data for policy/lead/customer forms. NOTE: 'health' still appears "
                     "as an option in several dropdowns even though HealthInsurance was removed from the "
                     "app — there is no endpoint to actually create a health policy."),
    req("Get Insurance Companies", "GET", "agent/insurance_companies",
        query=[qp("page", 1), qp("per_page", 20), qp("search", "", "matches name or code"),
               qp("status", "", "active|inactive|all")],
        auth=AGENT,
        description="Real DB-backed InsuranceCompany directory — distinct from the hardcoded static list "
                     "in form_data."),
    req("List Leads", "GET", "agent/leads",
        query=[qp("page", 1), qp("per_page", 10), qp("stage", "", "optional"),
               qp("product", "", "optional"), qp("search", "", "optional")],
        auth=AGENT,
        description="Every authenticated agent/sub-agent sees ALL leads system-wide — no agent-scoping "
                     "is applied (explicit in code comments)."),
    req("Add Lead", "POST", "agent/leads", auth=AGENT,
        body={
            "name": "Suresh Rao",
            "contact_number": "9812345678",
            "email": "suresh@example.com",
            "product_interest": "life",
            "address": "MG Road",
            "city": "Bengaluru",
            "state": "Karnataka",
            "lead_source": "agent_referral",
        },
        description="Response envelope uses `status` (boolean), not `success`. Duplicate contact_number/"
                     "email against ANY existing lead (not scoped to caller) is rejected with 422."),
    req("Get Commission Distribution", "GET", "agent/commission_distribution",
        query=[qp("page", 1), qp("per_page", 10),
               qp("period", "", "this_month|last_month|this_year|all"),
               qp("policy_type", "", "optional")],
        auth=AGENT,
        description="Sub-agent-tier CommissionPayout rows only, regardless of caller tier. NOTE: "
                     "policy_number/customer_name are always 'N/A' in current code — a known gap, not "
                     "a bug in this collection (see docs)."),
    req("Get Commission Summary", "GET", "agent/commission_summary", auth=AGENT,
        description="Aggregate earnings (total/paid/pending, this/last month) by policy_type. Computed "
                     "differently for sub-agents (from LifeInsurance directly) vs. agents/admins (from "
                     "CommissionPayout, unscoped)."),
]

FOLDERS = [
    ("Authentication", authentication,
     "Login, registration, password recovery, and OTP login. None of these endpoints require an "
     "Authorization header."),
    ("E-commerce - Catalog & Search", catalog,
     "Category/product browsing, search, filters, and ecommerce banners. Only products/banners/"
     "featured_products are public — everything else here needs a customer bearer token."),
    ("E-commerce - Delivery Validation & Location", delivery_validation,
     "Three independent delivery-checking mechanisms (product DeliveryRule, global DeliveryCharge, "
     "external India Post pincode API) — see each request's description for which one it uses."),
    ("Customer Profile", customer_profile, "Authenticated customer's own profile (Ecommerce controller)."),
    ("E-commerce - Bookings & Checkout", bookings,
     "Two separate order-placement flows with different payment models — see request descriptions."),
    ("E-commerce - Orders", orders, "Order records (distinct from Booking) for the authenticated customer."),
    ("E-commerce - Subscriptions", subscriptions,
     "Recurring milk-delivery subscriptions (MilkSubscription model, despite the generic route name)."),
    ("Customer Wallet", wallet, "Balance + transaction history. See docs/CUSTOMER_WALLET_API.md."),
    ("Customer Portfolio", portfolio, "Insurance policy list + installment/renewal reminders (Life + Motor)."),
    ("Settings", settings, "Profile, password, terms, contact, and helpdesk — shared across roles."),
    ("Banners", banners, "Standalone banner module — all 4 endpoints are public, no auth required."),
    ("Delivery Person", delivery_person,
     "Delivery-person task management. AUTH CAVEAT: only 'tasks/today' is scoped to the caller — every "
     "other endpoint here acts on any task id supplied, with no ownership check (see docs)."),
    ("Agent Dashboard, Leads & Commission", agent,
     "Agent/sub-agent/admin facing endpoints. Requires role 'agent' or 'sub_agent' in the JWT."),
]

collection = {
    "info": {
        "_postman_id": uid(),
        "name": "Ecommerce Store MS — Mobile API",
        "description": (
            "End-to-end collection for every endpoint under /api/v1/mobile, generated from "
            "docs/MOBILE_API.md and docs/CUSTOMER_WALLET_API.md (the authoritative, code-verified "
            "reference for this API as of 2026-09-02).\n\n"
            "## Setup\n"
            "1. Set the `base_url` collection variable (default `http://localhost:3000`).\n"
            "2. Run **Authentication > Login (Customer)** (or **Verify OTP**) — the `token` variable "
            "is saved automatically from the response.\n"
            "3. For the Agent folder, run **Authentication > Login (Agent / Sub-agent)** to populate "
            "`agent_token`; for Delivery Person, run **Login (Delivery Person)** to populate "
            "`delivery_token`.\n"
            "4. Fill in resource-id variables (`product_id`, `booking_id`, `category_id`, "
            "`subscription_id`, `order_id`, `banner_id`, `task_id`, `pincode`) as you create/observe "
            "real records, or override them per-request.\n\n"
            "## Known API quirks worth testing against (see docs for details)\n"
            "- Several delivery-check endpoints return **HTTP 200 even when the result is 'not "
            "deliverable'** — always check the `data` payload, not just the status code.\n"
            "- `POST /agent/customers` and `POST /agent/leads` use `{status, message, data}`, not "
            "`{success, message, data}` like almost everything else.\n"
            "- `POST /delivery/bulk_update` with `status: \"failed\"` currently 500s and aborts the "
            "whole batch (invalid enum value server-side) — avoid it until fixed.\n"
            "- Wallet payment (`booking[use_wallet]`) is documented separately in "
            "CUSTOMER_WALLET_API.md and lives on `POST ecommerce/bookings`, not its own endpoint.\n"
        ),
        "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json",
    },
    "auth": {"type": "bearer", "bearer": [{"key": "token", "value": "{{token}}", "type": "string"}]},
    "variable": [
        {"key": "base_url", "value": "http://localhost:3000", "type": "string"},
        {"key": "token", "value": "", "type": "string", "description": "Customer bearer token (auto-set by login/OTP-verify)"},
        {"key": "agent_token", "value": "", "type": "string", "description": "Agent/sub-agent bearer token"},
        {"key": "delivery_token", "value": "", "type": "string", "description": "Delivery-person bearer token"},
        {"key": "customer_id", "value": "1", "type": "string"},
        {"key": "product_id", "value": "1", "type": "string"},
        {"key": "product_variant_id", "value": "1", "type": "string"},
        {"key": "category_id", "value": "1", "type": "string"},
        {"key": "booking_id", "value": "1", "type": "string"},
        {"key": "order_id", "value": "1", "type": "string"},
        {"key": "subscription_id", "value": "1", "type": "string"},
        {"key": "banner_id", "value": "1", "type": "string"},
        {"key": "task_id", "value": "1", "type": "string"},
        {"key": "pincode", "value": "560001", "type": "string"},
        {"key": "reset_token", "value": "", "type": "string"},
    ],
    "item": [
        {"name": name, "description": desc, "item": items}
        for name, items, desc in FOLDERS
    ],
}

out_path = "docs/postman/Ecommerce_Store_MS_Mobile_API.postman_collection.json"
with open(out_path, "w") as f:
    json.dump(collection, f, indent=2)
print(f"wrote {out_path}")
