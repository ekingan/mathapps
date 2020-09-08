class Client < ApplicationRecord
  belongs_to :user
  belongs_to :address, optional: true
  belongs_to :spouse, class_name: "Client", optional: true
  accepts_nested_attributes_for :user, :spouse, :address
  enum entity_type: [:INDIVIDUAL, :PARTNERSHIP, :S_CORP, :C_CORP, :NON_PROFIT, :TRUST, :ESTATE]
  validates_presence_of :first_name, :last_name, :email, :user_id, :entity_type
  validates_uniqueness_of :email

  scope :active, -> { where.not(discontinued: :true) }
  scope :inactive, -> { where(discontinued: :true) }

  def full_name
    first_name + ' ' + last_name
  end

  def married?
    spouse.present?
  end
end
