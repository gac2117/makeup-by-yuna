class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :artist_id, :client_id, :date_time, :service, :comments

  belongs_to :client
  belongs_to :artist
end
