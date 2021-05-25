class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.float :total_amount
      t.float :tax_amount
      t.float :subtotal
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
