class AddInvoiceTemplateToSystemSettings < ActiveRecord::Migration[8.0]
  def change
    add_column :system_settings, :invoice_template, :string, default: 'classic'
  end
end
