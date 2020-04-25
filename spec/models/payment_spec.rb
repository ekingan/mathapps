require 'rails_helper'

RSpec.describe Payment, type: :model do
  let!(:job) { create(:job, price: 100.00) }
  let!(:client) { create(:client) }
  subject {
    described_class.create(
      payment_type: 'check',
      amount: 100.00,
      check_number: 1234,
      notes: 'hello',
      job_id: job.id
    )
  }
  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    context 'required' do
      it "is not valid without an amount" do
        subject.amount = nil
        expect(subject).to_not be_valid
      end
    end

    context 'not required' do
      it 'is valid without a payment type' do
        subject.payment_type = nil
        expect(subject).to be_valid
      end

      it 'is valid without notes' do
        subject.notes = nil
        expect(subject).to be_valid
      end

      it 'is valid without a check number' do
        subject.check_number = nil
        expect(subject).to be_valid
      end
    end

    context 'valid amount' do
      it 'validates the amount is at least 1' do
        job = create(:job, price: 0)
        expect(Payment.create(amount: 0.01, job: job).errors.full_messages).to eq ['Amount must be more than 1']
      end

      it 'validates the amount equals the price of the job' do
        expect(Payment.create(amount: 99, job: job).errors.full_messages).to eq(
          ["Payment must equal $100.0. If this is a partial payment, please check the partial payment box"]
        )
      end

      it 'validates a partial payment' do
        job = create(:job, price: 200)
        expect(Payment.create(amount: 300, partial_payment: true, job: job).errors.full_messages).to eq(
          ["Payment must not exceed $200.0"]
        )
      end
    end
  end

  describe 'Defaults' do
    subject {
      described_class.create(
        amount: 123,
        job_id: job.id,
      )
    }
    it 'defaults to partial payment false' do
      expect(subject.partial_payment).to be_falsey
    end
  end

  describe '#total_due' do
    it 'calculates the total due for the job' do
      expect(subject.total_due).to eq job.price
    end
  end

  describe 'sum_of_payments' do
    it 'adds up all payments for a given job' do
      Payment.create(job_id: job.id, partial_payment: true, amount: 25)
      Payment.create(job_id: job.id, partial_payment: true, amount: 50)
      expect(Payment.last.sum_of_payments.to_i).to eq 75
    end
  end
end
