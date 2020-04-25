class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.decimal :amount, null: false
      t.integer :payment_type
      t.integer :check_number
      t.text :notes
      t.boolean :partial_payment, default: false
      t.references :job, foreign_key: true

      t.timestamps
    end
  end
end
