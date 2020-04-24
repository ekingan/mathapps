require 'rails_helper'

RSpec.describe Job, type: :model do
  let!(:user) { create(:user) }
  let!(:client) { create(:client) }
  subject {
    described_class.create(
      job_type: 'consulting',
      price: 100.00,
      paid_in_full: false,
      status: 'ready',
      notes: 'awesome',
      due_date: '01/01/2020',
      user_id: user.id,
      client_id: client.id
    )
  }
  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    context 'required' do
      it "is not valid without a status" do
        subject.status = nil
        expect(subject).to_not be_valid
      end

      it "is not valid without a user" do
        subject.user_id = nil
        expect(subject).to_not be_valid
      end

      it "is not valid without a client id" do
        subject.client_id = nil
        expect(subject).to_not be_valid
      end
    end

    context 'not required' do
      it 'is valid without a due dateh' do
        subject.due_date = nil
        expect(subject).to be_valid
      end

      it 'is valid without notes' do
        subject.notes = nil
        expect(subject).to be_valid
      end
    end
  end

  describe 'Defaults' do
    subject {
      described_class.create(
        user_id: user.id,
        client_id: client.id
      )
    }
    it 'defaults to status todo' do
      expect(subject.status).to eq 'todo'
    end

    it 'defaults to job type tax return' do
      expect(subject.job_type).to eq 'tax_return'
    end

    it 'defaults to price of 0' do
      expect(subject.price).to eq  0.0
    end

    it 'defaults to paid in full false' do
      expect(subject.paid_in_full).to be_falsey
    end
  end
end
