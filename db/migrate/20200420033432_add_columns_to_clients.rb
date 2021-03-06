class AddColumnsToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :entity_type, :integer, null: false, default: 0
    add_column :clients, :discontinued, :boolean, default: false
    add_column :clients, :notes, :text
    add_reference :clients, :spouse, foreign_key: { to_table: :clients }
  end
end
