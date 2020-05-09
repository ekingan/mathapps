class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email, null: false, unique: true
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :image_url
      t.text :bio
      t.integer :role
      t.string :subdomain

      t.timestamps
    end
  end
end
