class AddQuickInvoiceToBookingsAndInvoices < ActiveRecord::Migration[8.0]
  def change
    add_column :bookings, :quick_invoice, :boolean, default: false
    add_column :invoices, :quick_invoice, :boolean, default: false
  end
end
