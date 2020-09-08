require 'rails_helper'

RSpec.describe SpouseService do
  let(:user) { create(:user) }
  let(:client) { create(:client, user: user) }
  let(:spouse) { create(:client, user:user)}

  describe '#divorce' do
    before do
      client.spouse = spouse
      spouse.spouse = client
      client.save
      spouse.save
    end
    it 'removes spouse relationship for client' do
      expect(client.spouse).to eq spouse
      described_class.new(client).divorce
      expect(client.spouse).to be_nil
    end
    it 'removes spouse relationship for spouse' do
      expect(spouse.spouse).to eq client
      described_class.new(client).divorce
      expect(spouse.spouse).to be_nil
    end
  end
end

