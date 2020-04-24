class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.integer "job_type", default: 0, null: false
      t.float "price", default: 0.0
      t.boolean "paid_in_full", default: false, null: false
      t.text "notes"
      t.date :due_date
      t.integer :status, default: 0, null: false
      t.references :client, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
