class ClientInformationService
  def initialize(params)
    @client_id = params[:id]
    @client_params = params.dig(:client)
    @preparer_id = @client_params.dig(:user_id)
    @spouse_params = client_params.delete(:spouse_attributes) || {}
    @address_params = client_params.delete(:address_attributes) || {}
  end

  attr_reader :client_params, :spouse_params, :address_params, :preparer_id, :client_id

  def create
    ActiveRecord::Base.transaction do
      if address_present?
        address = create_address
        create_address if spouse_present?
      end
      if spouse_present?
        spouse_params.merge!(user_id: preparer_id)
        spouse = create_client(spouse_params, address)
      end
      create_client(client_params, spouse, address)
    end
  end

  def update
    ActiveRecord::Base.transaction do
      @client = Client.find client_id
      if address_present?
        address = update_address
      end
      if spouse_present?
        spouse = update_spouse
      end
      client_params.merge!(address_id: address.id) if address.present?
      client_params.merge!(spouse_id: spouse.id) if spouse.present?
      @client.update client_params
    end
  end

  private

  def create_client(params, spouse = nil, address = nil)
    params.merge!(spouse_id: spouse.id) unless spouse.nil?
    params.merge!(address_id: address.id) unless address.nil?
    client = Client.new(params)
    client.save
    client
  end

  def create_address
    Address.create(address_params)
  end

  def update_address
    if @client.address.present?
      address = Address.find @client.address_id
      address.update address_params
    else
      address = create_address
    end
    address
  end

  def update_spouse
    if @client.spouse.present?
      spouse = Client.find @client.spouse_id
      spouse.update spouse_params
    else
      create_client(spouse_params, client, address)
    end
    spouse
  end

  def address_present?
    address_params.to_hash.values.join != ("OR" || "")
  end

  def spouse_present?
    spouse_params.to_hash.values.join != ""
  end
end
