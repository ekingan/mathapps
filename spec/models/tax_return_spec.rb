require 'rails_helper'

RSpec.describe TaxReturn, type: :model do
  let!(:job) { create(:job) }
  subject {
    described_class.create(
      fed_form: 'Individual_1040',
      tax_year: 2017,
      primary_state: 'OR',
      other_states: 'NY',
      printed: true,
      scanned: true,
      uploaded: false,
      filed: '4/15/2020',
      ack_fed: '4/16/2020',
      ack_primary_state: '4/17/2020',
      ack_other_states: '4/18/2020',
      rejected: false,
      notes: 'awesome',
      job_id: job.id
    )
  }
  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    context 'required' do
      it "is not valid without a fed form" do
        subject.fed_form = nil
        expect(subject).to_not be_valid
      end

      it "is not valid without a job" do
        subject.job_id = nil
        expect(subject).to_not be_valid
      end

      it "is not valid without a tax year" do
        subject.tax_year = nil
        expect(subject).to_not be_valid
      end
    end

    context 'not required' do
      it 'is valid without a primary state' do
        subject.primary_state = nil
        expect(subject).to be_valid
      end

      it 'is valid without other states' do
        subject.other_states = nil
        expect(subject).to be_valid
      end

      it 'is valid without a filed date' do
        subject.filed = nil
        expect(subject).to be_valid
      end

      it 'is valid without an ack fed' do
        subject.ack_fed = nil
        expect(subject).to be_valid
      end

      it 'is valid without an ack primary state' do
        subject.ack_primary_state = nil
        expect(subject).to be_valid
      end

      it 'is valid without an ack other states' do
        subject.ack_other_states = nil
        expect(subject).to be_valid
      end
    end
  end

  describe 'Defaults' do
    subject {
      described_class.create(
        fed_form: 'Individual_1040',
        tax_year: 2017,
        primary_state: 'OR',
        other_states: 'NY',
        filed: '4/15/2020',
        ack_fed: '4/16/2020',
        ack_primary_state: '4/17/2020',
        ack_other_states: '4/18/2020',
        notes: 'awesome',
        job_id: job.id
      )
    }
    it 'defaults to printed false' do
      expect(subject.printed).to be_falsey
    end

    it 'defaults to scanned false' do
      expect(subject.scanned).to be_falsey
    end

    it 'defaults to uploaded false' do
      expect(subject.uploaded).to be_falsey
    end

    it 'defaults to rejected false' do
      expect(subject.rejected).to be_falsey
    end

    context 'tax year' do
      subject {
        described_class.create(
          fed_form: 'Individual_1040',
          tax_year: nil,
          job_id: job.id
        )
      }
      it 'sets the current tax year if year not present' do
        expect(subject.tax_year).to eq 2019
      end
    end
  end
end
