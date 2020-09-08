class SpouseService
  attr_accessor :client, :spouse

  def initialize(client)
    @client = client
    @spouse = client.spouse
  end

  def divorce
    Client.transaction do
      [client, spouse].each { |person| remove_spouse(person) }
    end
  end

  def marry
    Client.transaction do
      client.spouse = spouse
      spouse.spouse = client
      client.save!
      spouse.save!
    end
  end

  private

  def remove_spouse(person)
    person.update(spouse_id: nil)
  end
end
