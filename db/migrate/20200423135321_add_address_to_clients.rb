class AddAddressToClients < ActiveRecord::Migration[6.0]
  def change
    add_reference :clients, :address, index: true
    add_foreign_key :clients, :addresses
  end
end
