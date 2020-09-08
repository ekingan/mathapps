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
  let(:client_and_spouse) do
    client_params[:spouse_attributes] = strong_params(spouse_params)
    client_params[:address_attributes] = strong_params(empty_address_params)
    params = {client: strong_params(client_params)}
    strong_params(params)
  end
  let(:client_and_address) do
    client_params[:spouse_attributes] = strong_params(empty_spouse_params)
    client_params[:address_attributes] = strong_params(address_params)
    params = {client: strong_params(client_params)}
    strong_params(params)
  end

  describe '#create' do
    context 'when client params are present' do
      let(:subject) { described_class.new(client_params_only) }
      it 'creates a new client' do
        expect { subject.create }.to change { Client.count }.by 1
      end
      it 'does not create a new spouse' do
        subject.create
        expect(Client.last.spouse_id).to be_nil
      end
      it 'does not create a new address' do
        expect { subject.create }.not_to change { Address.count }
        expect(Client.last.address_id).to be_nil
      end
    end
    context 'when client and spouse params are present' do
      let(:subject) { described_class.new(client_and_spouse) }
      it 'creates a new client and a new spouse' do
        expect { subject.create }.to change { Client.count }.by 2
      end
      it 'saves the spouse id to the client' do
        subject.create
        expect(Client.last.spouse_id).to eq Client.first.id
      end
      it 'saves the client id to the spouse' do
        subject.create
        expect(Client.first.spouse_id).to eq Client.last.id
      end
      it 'does not create a new address for the client' do
        expect { subject.create }.not_to change { Address.count }
        expect(Client.last.address_id).to be_nil
      end
      it 'does not create a new address for the spouse' do
        expect { subject.create }.not_to change { Address.count }
        expect(Client.first.address_id).to be_nil
      end
    end
    context 'when client and address params are present' do
      let(:subject) { described_class.new(client_and_address) }
      it 'creates a new client' do
        expect { subject.create }.to change { Client.count }.by 1
      end
      it 'creates a new address record' do
        expect { subject.create }.to change { Address.count }.by 1
      end
      it 'saves the address to the client' do
        subject.create
        expect(Client.last.address_id).to eq Address.last.id
      end
    end
    context 'when client, spouse, and address params are present' do
      let(:subject) { described_class.new(full_params) }
      it 'creates a new and spouse client' do
        expect { subject.create }.to change { Client.count }.by 2
      end
      it 'creates a new address record' do
        expect { subject.create }.to change { Address.count }.by 1
      end
      it 'saves the spouse id to the client' do
        subject.create
        expect(Client.last.spouse_id).to eq Client.first.id
      end
      it 'saves the client id to the spouse' do
        subject.create
        expect(Client.first.spouse_id).to eq Client.last.id
      end
      it 'saves the address to the client' do
        subject.create
        expect(Client.last.address_id).to eq Address.last.id
      end
      it 'saves the address to the spouse' do
        subject.create
        expect(Client.first.address_id).to eq Address.last.id
      end
    end
  end
  describe '#update' do
    context 'when updating the client only' do
      let!(:client) { create(:client) }
      let(:client_params_only) do
        client_params[:spouse_attributes] = strong_params(empty_spouse_params)
        client_params[:address_attributes] = strong_params(empty_address_params)
        params = {client: strong_params(client_params)}
        strong_params(params.merge!(id: client.id))
      end
      let(:subject) { described_class.new(client_params_only) }
      it 'updates the client' do
        subject.update
        expect(client.reload.first_name).to eq client_params['first_name']
        expect(client.last_name).to eq client_params['last_name']
        expect(client.email).to eq client_params['email']
      end
    end
  end
end