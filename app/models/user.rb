class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
  after_create :create_tenant

  private

  def create_tenant
    Apartment::Tenant.create(subdomain)
  end
end
