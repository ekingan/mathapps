require 'rails_helper'

RSpec.describe Client, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:address) { FactoryBot.create(:address) }
  subject {
    described_class.create(
      first_name: 'Yvonne',
      last_name: 'Carter',
      date_of_birth: '11/15/1976',
      email: 'yvonne@gmail.com',
      phone: 5032344959,
      occupation: 'BallBoy',
      user_id: user.id,
      address_id: address.id,
      discontinued: false
    )
  }
  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    context 'required' do
      it "is not valid without a password" do
        subject.last_name = nil
        expect(subject).to_not be_valid
      end

      it "is not valid without an email" do
        subject.email = nil
        expect(subject).to_not be_valid
      end

      it "is not valid without a first name" do
        subject.first_name = nil
        expect(subject).to_not be_valid
      end

      it "is not valid without a last name" do
        subject.last_name = nil
        expect(subject).to_not be_valid
      end

      it "is not valid without an entity type" do
        subject.entity_type = nil
        expect(subject).to_not be_valid
      end

      it "is not valid without a user id" do
        subject.user_id = nil
        expect(subject).to_not be_valid
      end
    end

    context 'not required' do
      it 'is valid without a date of birth' do
        subject.date_of_birth = nil
        expect(subject).to be_valid
      end

      it 'is valid without a phone number' do
        subject.phone = nil
        expect(subject).to be_valid
      end

      it 'is valid without an occupation' do
        subject.occupation = nil
        expect(subject).to be_valid
      end
    end
  end

  describe 'Defaults' do
    it 'defaults to entity type Individual' do
      expect(subject.entity_type).to eq 'INDIVIDUAL'
    end

    it 'defaults to discontinued false' do
      expect(subject.discontinued).to be_falsey
    end
  end

  describe '#full_name' do
    it 'has a full name' do
      expect(subject.full_name).to eq 'Yvonne Carter'
    end
  end
end
