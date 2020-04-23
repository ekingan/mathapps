class Client < ApplicationRecord
  belongs_to :user
  belongs_to :address
  enum entity_type: [:INDIVIDUAL, :PARTNERSHIP, :S_CORP, :C_CORP, :NON_PROFIT, :TRUST, :ESTATE]
  validates_presence_of :first_name, :last_name, :email, :user_id, :entity_type
  validates_uniqueness_of :last_name, :scope => :first_name

  scope :active, -> { where.not(discontinue: :true) }
  scope :inactive, -> { where(discontinue: :true) }

  def full_name
    first_name + ' ' + last_name
  end
end
