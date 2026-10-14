require "net/http"; require "json"; require "uri"; require "securerandom"
# Cashfree live-account check: creates a Rs 1 order and asks for a UPI /
# netbanking payment LINK (nothing is charged). Prints Cashfree's answers,
# never the keys. Usage: ruby script/cashfree_diagnose.rb [env-file]
# (no file = use CASHFREE_APP_ID / CASHFREE_SECRET_KEY from the environment)
env = if ARGV[0]
  File.readlines(ARGV[0]).filter_map { |l| k, v = l.strip.split("=", 2); [k, v.to_s.delete('"')] if k&.start_with?("CASHFREE_") }.to_h
else
  ENV.to_h
end
id, secret = env["CASHFREE_APP_ID"], env["CASHFREE_SECRET_KEY"]
puts "App ID: #{id[0, 6]}…#{id[-4..]}  secret type: #{secret[0, 13]}…"
H = { "x-client-id" => id, "x-client-secret" => secret, "x-api-version" => "2023-08-01", "Content-Type" => "application/json", "Accept" => "application/json" }
def call(method, path, body = nil)
  uri = URI("https://api.cashfree.com/pg#{path}")
  req = (method == :post ? Net::HTTP::Post : Net::HTTP::Get).new(uri, H)
  req.body = body.to_json if body
  res = Net::HTTP.start(uri.host, 443, use_ssl: true, open_timeout: 10, read_timeout: 20) { |h| h.request(req) }
  $last_request_id = res["x-request-id"]
  [res.code, (JSON.parse(res.body) rescue res.body)]
end
oid = "MKS_DIAG_#{Time.now.strftime('%Y%m%d%H%M%S')}_#{SecureRandom.hex(2).upcase}"
code, order = call(:post, "/orders", { order_id: oid, order_amount: 1.0, order_currency: "INR",
  customer_details: { customer_id: "diag_check", customer_phone: "9999999999", customer_name: "Diagnostic" },
  order_meta: { return_url: "https://maralisanthe.com/" }, order_note: "Diagnostic - safe to ignore" })
puts "Order ID sent: #{oid}  at #{Time.now.strftime('%Y-%m-%d %H:%M:%S %z')}  x-request-id: #{$last_request_id || 'none'}"
puts "1) Create order: HTTP #{code} -> status=#{order['order_status'] rescue nil} #{order.is_a?(Hash) ? order.slice('message', 'code', 'type') : order.to_s[0, 200]}"
exit unless order.is_a?(Hash) && order["payment_session_id"]
code, pay = call(:post, "/orders/sessions", { payment_session_id: order["payment_session_id"], payment_method: { upi: { channel: "link" } } })
puts "2) UPI link attempt: HTTP #{code} -> #{pay.is_a?(Hash) ? pay.reject { |k, _| k == 'data' }.merge('has_payment_links' => !!pay.dig('data', 'payload')) : pay.to_s[0, 300]}"
code, card = call(:post, "/orders/sessions", { payment_session_id: order["payment_session_id"], payment_method: { netbanking: { channel: "link", netbanking_bank_code: 3003 } } })
puts "3) Netbanking attempt: HTTP #{code} -> #{card.is_a?(Hash) ? card.reject { |k, _| k == 'data' } : card.to_s[0, 300]}"
