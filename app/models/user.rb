class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
  after_create :create_tenant
  enum role: [:admin, :preparer]
  validates_presence_of :first_name, :last_name, :email, :password


  def full_name
    first_name + ' ' + last_name
  end

  private

  def create_tenant
    Apartment::Tenant.create(subdomain)
  end
end
