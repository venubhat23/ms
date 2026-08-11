# Mobile App OTP Login — Setup Guide

Backend implementation is done (see "What's already built" below). This doc covers the
external registration steps you still need to do before real OTP SMS can be sent, and how
to plug the resulting credentials into this app.

## Part 1: What is DLT and why do you need it?

DLT (Distributed Ledger Technology) registration is a rule made by **TRAI** (India's
telecom regulator). It exists to stop spam SMS. The rule: **any business sending SMS to
customers in India — including OTP SMS — must register itself and its message content
first.** If you don't register, telecom companies (Airtel, Jio, etc.) will silently block
your SMS. Your OTP just won't arrive, and you'll have no error to debug — this is the #1
reason "OTP not received" bugs happen for first-timers.

It has **3 separate registrations**, done in this exact order:

1. **Principal Entity (PE)** — this is *you*, the business, registering once.
2. **Sender ID / Header** — a 6-letter code like `ATMNRB` that appears as who sent the SMS.
3. **Template** — the exact SMS text you'll send, word for word, pre-approved.

## Part 2: What is MSG91?

MSG91 is an SMS-sending company (like an email provider, but for SMS/OTP). Instead of
dealing directly with Airtel/Jio DLT portals (confusing, telecom-operator-specific),
MSG91 gives you one dashboard that handles DLT registration *for* you and then lets you
send OTPs through a simple API call. The backend code (`OtpSmsService`) is built around
MSG91 for this reason — it's the easiest path for a first-timer.

## Part 3: Step-by-step setup

**Step 1 — Create an MSG91 account**
Go to msg91.com → Sign Up → verify your own email/mobile. Free to create, no cost yet.

**Step 2 — Register as Principal Entity (PE)**
Inside the MSG91 dashboard, there's a "DLT Registration" / "Trueblue DLT" section. Click
it and fill in:
- Business PAN
- GST number (already stored in this app's `system_settings`)
- Business address, authorized signatory name/mobile/email

Submit. This step costs **~₹5,900 one-time** (paid to the DLT platform, not MSG91) and
takes **1–3 business days** to get approved. MSG91's in-dashboard wizard picks the telecom
DLT platform for you — no need to visit Airtel/Jio's site separately.

**Step 3 — Register your Sender ID (Header)**
Once PE is approved, register a 6-letter Sender ID, e.g. `ATMNRB`. Needs approval, usually
faster (~1 day). This becomes the "From" name on the SMS.

**Step 4 — Register your OTP Template**
This is the exact text of the SMS. It **must match character-for-character** what the code
sends, or it gets blocked even after approval. Use MSG91's variable placeholder `##OTP##`
where the number goes. Example to submit:

> Your OTP for login is ##OTP##. Valid for 5 minutes. Do not share this OTP with anyone. - AtmaNirbhar Farm

Submit for approval (usually same-day to 24h). Once approved, MSG91 gives you a
**Template ID**.

**Step 5 — Collect your 3 credentials**
After all approvals, go to MSG91 dashboard → API section, and note down:
- **Auth Key** (your account's API key)
- **Sender ID** (the 6-letter header from Step 3)
- **Template ID** (from Step 4)

## Part 4: Plugging it into this codebase

These 3 values go into `.env` (placeholders already added there):

```
MSG91_AUTH_KEY=<paste auth key>
MSG91_SENDER_ID=<paste sender id>
MSG91_OTP_TEMPLATE_ID=<paste template id>
```

On Railway, set the same 3 as environment variables in the project's Variables tab (not
`.env`, since `.env` isn't deployed). Nothing else changes — `OtpSmsService`
(`app/services/otp_sms_service.rb`) automatically switches from "log the OTP to console"
(what it does with no credentials set) to "actually send real SMS" the moment these 3 are
set.

## Part 5: Turning it on and testing

1. Set the 3 env vars on Railway → redeploy.
2. Go to `/admin/settings/system` → flip "Enable OTP Login" → Save.
3. From the mobile app (or Postman), call `POST /api/v1/mobile/auth/otp/request` with a
   real mobile number → real SMS should arrive within seconds.
4. Call `POST /api/v1/mobile/auth/otp/verify` with that code → returns a login token.

Until DLT is done, you can leave the admin toggle on for your own testing — with no MSG91
credentials configured, the OTP is printed to the server logs instead of texted, so the
full login flow can be exercised without waiting on DLT approval.

## Timeline & cost to expect

- PE approval: 1–3 business days, ~₹5,900 one-time
- Sender ID approval: ~1 day
- Template approval: same-day to 24h
- **Total: roughly 3–5 business days before the first real OTP SMS can go out.**

## What's already built (backend)

- `SystemSetting.otp_login_enabled?` — admin kill-switch, default off, toggled at
  `/admin/settings/system`.
- `OtpVerification` model — hashed OTP storage, 5-min expiry, 60s resend cooldown,
  5 requests/hour cap, 5 max verify attempts.
- `OtpSmsService` — sends via MSG91; logs to console instead when credentials are unset.
- `POST /api/v1/mobile/auth/otp/request` and `POST /api/v1/mobile/auth/otp/verify` —
  gated by the admin toggle, issue the same JWT format as the existing password login.
  First-time mobile numbers get a minimal `User`+`Customer` auto-created
  (`is_new_user: true` in the response), so the app can prompt for profile completion
  afterward via the existing `PUT /settings/profile`.

## Sources

- [Steps For DLT Process Registration — MSG91](https://msg91.com/guide/steps-for-dlt-process-registration)
- [Step by Step Guide to implement DLT in SMS — MSG91](https://msg91.com/help/dlt-registration-in-india/step-by-step-guide-to-implement-dlt-in-sms)
- [How to create a template to Send OTP — MSG91](https://msg91.com/help/sendotp/where-to-find-the-sendotp-api-how-to-get-template-id)
- [DLT Registration: Complete TRAI Guide for India (2026) — SMSCountry](https://www.smscountry.com/blog/dlt-registration/)
- [TRAI DLT Registration 2025: Complete Guide — 2Factor](https://2factor.in/v3/dlt/trai-mandatory-dlt-registration/)
