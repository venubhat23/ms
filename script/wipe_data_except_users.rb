# Deletes ALL rows from every table except users (and the auth tables users
# need to log in). Schema is untouched. IDs are reset to 1.
#
# Also kept by default:
#   system_settings  — site theme, business/invoice details, feature switches
#                      (set WIPE_SETTINGS=yes to wipe these too)
#   solid_queue_*    — background job bookkeeping; wiping it under a running
#                      worker can crash the worker
# The cache table (solid_cache_entries) IS wiped so nothing stale is served.
#
# From a shell:
#   Dry run (shows what would be wiped, deletes nothing):
#     bin/rails runner script/wipe_data_except_users.rb
#   Actually wipe:
#     CONFIRM=yes bin/rails runner script/wipe_data_except_users.rb
#   Keep extra tables:
#     KEEP=categories,products CONFIRM=yes bin/rails runner script/wipe_data_except_users.rb
#
# From `bin/rails console`:
#   load "script/wipe_data_except_users.rb"                              # dry run
#   ENV["CONFIRM"] = "yes"; load "script/wipe_data_except_users.rb"      # wipe

conn = ActiveRecord::Base.connection

keep = %w[
  users
  roles
  user_roles
  permissions
  schema_migrations
  ar_internal_metadata
]
keep << "system_settings" unless ENV["WIPE_SETTINGS"] == "yes"
keep += ENV.fetch("KEEP", "").split(",").map(&:strip).reject(&:empty?)
keep += conn.tables.grep(/\Asolid_queue_/)

tables = conn.tables - keep
db     = conn.current_database
host   = ActiveRecord::Base.connection_db_config.configuration_hash[:host] || "localhost"

puts "Database: #{db} @ #{host} (#{Rails.env})"
puts "Keeping:  #{keep.sort.join(', ')}"
puts
puts "Will wipe #{tables.size} tables:"
tables.sort.each do |t|
  count = conn.select_value("SELECT COUNT(*) FROM #{conn.quote_table_name(t)}")
  puts format("  %-45s %8d rows", t, count)
end
puts

if ENV["CONFIRM"] == "yes"
  ActiveRecord::Base.transaction do
    # No CASCADE on purpose: if a kept table has a foreign key into a wiped
    # table, Postgres raises (and nothing is deleted) instead of silently
    # truncating the kept table too.
    quoted = tables.map { |t| conn.quote_table_name(t) }.join(", ")
    conn.execute("TRUNCATE TABLE #{quoted} RESTART IDENTITY")

    # Clear user columns that now point at deleted rows.
    User.unscoped.where.not(assigned_store_id: nil).update_all(assigned_store_id: nil)
    User.unscoped.where.not(authenticatable_type: [nil, "User"])
        .update_all(authenticatable_type: nil, authenticatable_id: nil)
  end
  ENV.delete("CONFIRM") # so a second `load` in the same console is a dry run again

  puts "Done. Users remaining: #{User.unscoped.count}"
  puts "Restart the Rails server so in-memory caches start empty."
else
  puts "Dry run only — nothing deleted. Re-run with CONFIRM=yes to delete."
end
