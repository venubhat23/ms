#!/usr/bin/env bash
# Times every read-only (GET) mobile API endpoint against a server and prints,
# per endpoint, the server's own processing time (x-runtime header) next to
# the total time the request took from this machine. Only GET requests are
# sent — nothing is created or changed.
#
# Usage:
#   MOBILE_LOGIN=9876543210 MOBILE_PASSWORD=secret script/measure_mobile_api.sh
#   BASE_URL=http://localhost:3000 MOBILE_LOGIN=... MOBILE_PASSWORD=... script/measure_mobile_api.sh
#
# Use a test customer account. Each endpoint is called 3 times on one reused
# connection; the first call can be slower (cold cache).
set -euo pipefail

BASE_URL="${BASE_URL:-https://maralisanthe.com}"
API="$BASE_URL/api/v1/mobile"

token=""
if [[ -n "${MOBILE_LOGIN:-}" && -n "${MOBILE_PASSWORD:-}" ]]; then
  token=$(curl -s -X POST "$API/auth/login" -H 'Content-Type: application/json' \
    -d "{\"username\":\"$MOBILE_LOGIN\",\"password\":\"$MOBILE_PASSWORD\"}" |
    ruby -rjson -e 'puts(JSON.parse(STDIN.read).dig("data", "token") || "")' 2>/dev/null || true)
  [[ -z "$token" ]] && echo "Login failed — measuring public endpoints only." >&2
fi

public_paths=(
  ecommerce/products "ecommerce/products?page=2" ecommerce/featured_products
  ecommerce/banners banners banners/locations
)
customer_paths=(
  ecommerce/categories ecommerce/filters "ecommerce/search?q=ghee"
  ecommerce/categories/1 ecommerce/categories/1/products
  ecommerce/bookings ecommerce/orders ecommerce/subscriptions ecommerce/profile
  customer/wallet settings/profile settings/terms settings/contact
)

measure() {
  local path=$1; shift
  local args=() runs="" server=""
  for _ in 1 2 3; do
    args+=(-s -o /dev/null -D - -w "TOTAL %{time_total} STATUS %{http_code}\n" "$@" "$API/$path" --next)
  done
  local out
  out=$(curl "${args[@]:0:${#args[@]}-1}")
  server=$(echo "$out" | awk 'tolower($1)=="x-runtime:" {printf "%5.0f", $2*1000}' | tr '\n' ' ')
  runs=$(echo "$out" | awk '$1=="TOTAL" {printf "%5.0f", $2*1000; status=$4} END {printf " | HTTP %s", status}' )
  printf "%-36s server ms:%s | total ms:%s\n" "$path" "$server" "$runs"
}

echo "Base: $BASE_URL"
for p in "${public_paths[@]}"; do measure "$p"; done
if [[ -n "$token" ]]; then
  for p in "${customer_paths[@]}"; do measure "$p" -H "Authorization: Bearer $token"; done
else
  echo "(set MOBILE_LOGIN and MOBILE_PASSWORD to also measure logged-in endpoints)"
fi
