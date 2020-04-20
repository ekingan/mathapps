require 'rails_helper'

RSpec.describe Client, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  subject {
    described_class.create(
      first_name: 'Yvonne',
      last_name: 'Carter',
      date_of_birth: '11/15/1976',
      email: 'yvonne@gmail.com',
      phone: 5032344959,
      street: '130 Red Road',
      city: 'Baltimore',
      state: 'OH',
      zip_code: '90321',
      occupation: 'BallBoy',
      user_id: user.id,
      entity_type: 2,
      discontinued: false
    )
  }
  describe "Validations" do
    it "is valid with valid attributes" do
      binding.pry
      expect(subject).to be_valid
    end

    it "is not valid without a password" do
      subject.last_name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without an email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end
  end
end
