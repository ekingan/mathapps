require 'rails_helper'

RSpec.describe User, type: :model do
  subject {
    described_class.create(
      first_name: 'Samuel',
      last_name: 'Sweet',
      email: 'ssweet@tmail.com',
      image_url: 'abc.jpg',
      bio: 'a great one!',
      role: 'admin',
      subdomain: 'home',
      password: 'password'
    )
  }
  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    context 'required' do
      it "is not valid without a password" do
        subject.password = nil
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
    end

    context 'not required' do
      it 'is valid without an image url' do
        subject.image_url = nil
        expect(subject).to be_valid
      end

      it 'is valid without a bio' do
        subject.bio = nil
        expect(subject).to be_valid
      end

      it 'is valid without a role' do
        subject.role = nil
        expect(subject).to be_valid
      end

      it 'is valid without a subdomain' do
        subject.subdomain = nil
        expect(subject).to be_valid
      end
    end
  end

  describe '#full_name' do
    it 'has a full name' do
      expect(subject.full_name).to eq 'Samuel Sweet'
    end
  end
end
