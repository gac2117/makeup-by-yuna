class AppointmentSerializer
  def initialize(appointment, include_associations: true)
    @appointment = appointment
    @include_associations = include_associations
  end

  def as_json(options = {})
    result = {
      id: @appointment.id,
      date_time: @appointment.date_time,
      service: @appointment.service,
      comments: @appointment.comments
    }
    
    if @include_associations
      result[:client] = { id: @appointment.client.id, name: @appointment.client.name }
      result[:artist] = { id: @appointment.artist.id, name: @appointment.artist.name }
    end
    
    result
  end
end
