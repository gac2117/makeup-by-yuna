class ArtistSerializer
  def initialize(artist, include_associations: true)
    @artist = artist
    @include_associations = include_associations
  end

  def as_json(options = {})
    result = {
      id: @artist.id,
      name: @artist.name
    }
    
    if @include_associations
      result[:appointments] = @artist.appointments.map { |app| AppointmentSerializer.new(app, include_associations: false).as_json }
      result[:clients] = @artist.clients.map { |client| { id: client.id, name: client.name } }
    end
    
    result
  end
end
