class CreateClientSpouseJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :clients, :spouses do |t|
      t.index [:client_id, :spouse_id]
      t.index [:spouse_id, :client_id]
    end
  end
end
