class Marriage < ApplicationRecord
  belongs_to :client
  belongs_to :spouse
end
