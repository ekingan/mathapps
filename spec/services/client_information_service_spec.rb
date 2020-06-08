require 'rails_helper'

RSpec.describe ClientInformationService do
  def strong_params(params)
    ActionController::Parameters.new(params).permit!
  end

  let(:user) { create(:user) }
  let(:client_params) do
    {
      'first_name' => 'Emily',
      'last_name' => 'Kingan',
      'email' => 'ekingan@hotmail.com',
      'user_id' => user.id,
      'entity_type' => 'INDIVIDUAL'
    }
  end
  let(:address_params) do
    {
      'street' => '4815 NE 30th Ave',
      'city' => 'Portland',
      'state' => 'OR',
      'zip_code' => '97211'
    }
  end
  let(:spouse_params) do
    {
      'first_name' => 'Carlos',
      'last_name' => 'Santana',
      'email' => 'cs@hotmail.com'
    }
  end
  let(:empty_address_params) do
    {
      'street' => '',
      'city' => '',
      'state' => 'OR',
      'zip_code' => ''
    }
  end
  let(:empty_spouse_params) do
    {
      'first_name' => '',
      'last_name' => '',
      'email' => ''
    }
  end
  let(:full_params) do
    client_params[:spouse_attributes] = strong_params(spouse_params)
    client_params[:address_attributes] = strong_params(address_params)
    params = {client: strong_params(client_params)}
    strong_params(params)
  end
  let(:client_params_only) do
    client_params[:spouse_attributes] = strong_params(empty_spouse_params)
    client_params[:address_attributes] = strong_params(empty_address_params)
    params = {client: strong_params(client_params)}
    strong_params(params)
  end

  describe '#create' do
    it 'creates a new client' do
      expect { described_class.new(client_params_only).create }.to change { Client.count }.by 1
    end
    context 'when spouse params are present' do
      let(:subject) { described_class.new(full_params) }
      it 'creates a new client and a new spouse' do
        expect { subject.create }.to change { Client.count }.by 2
      end
      it 'saves the spouse if to the client' do
        subject.create
        expect(Client.last.spouse_id).to eq Client.first.id
      end
      it 'saves the client id to the spouse' do
        subject.create
        expect(Client.first.spouse_id).to eq Client.last.id
      end
    end
  end
end