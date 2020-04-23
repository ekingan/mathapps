class Address < ApplicationRecord
  validates_presence_of :street, :city, :zip_code, :state
end
