class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.date :date_of_birth
      t.string :email, null: false
      t.string :phone
      t.string :occupation
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
