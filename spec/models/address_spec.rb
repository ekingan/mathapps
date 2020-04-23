require 'rails_helper'

RSpec.describe Address, type: :model do
  subject {
    described_class.create(
      street: '123 30th St',
      city: 'Clinton',
      state: 'MA',
      zip_code: '12345'
    )
  }
  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    context 'required' do
      it "is not valid without a street" do
        subject.street = nil
        expect(subject).to_not be_valid
      end

      it "is not valid without an city" do
        subject.city = nil
        expect(subject).to_not be_valid
      end

      it "is not valid without a state" do
        subject.state = nil
        expect(subject).to_not be_valid
      end

      it "is not valid without a zip code" do
        subject.zip_code = nil
        expect(subject).to_not be_valid
      end
    end

    context 'not required' do
      it 'is valid without a country' do
        subject.country = nil
        expect(subject).to be_valid
      end
    end
  end
end
