class ClientSerializer
  def initialize(client, include_associations: true)
    @client = client
    @include_associations = include_associations
  end

  def as_json(options = {})
    result = {
      id: @client.id,
      name: @client.name
    }
    
    if @include_associations
      result[:appointments] = @client.appointments.map { |app| AppointmentSerializer.new(app, include_associations: false).as_json }
      result[:artists] = @client.artists.map { |artist| { id: artist.id, name: artist.name } }
    end
    
    result
  end
end
