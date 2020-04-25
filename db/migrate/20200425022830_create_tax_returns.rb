class CreateTaxReturns < ActiveRecord::Migration[6.0]
  def change
    create_table :tax_returns do |t|
      t.integer :fed_form, null: false
      t.integer :tax_year, null: false
      t.string :primary_state
      t.string :other_states
      t.boolean :printed, default: false
      t.boolean :scanned, default: false
      t.boolean :uploaded, default: false
      t.date :filed
      t.date :ack_fed
      t.date :ack_primary_state
      t.date :ack_other_states
      t.boolean :rejected, default: false
      t.text :notes
      t.references :job, foreign_key: true

      t.timestamps
    end
  end
end
