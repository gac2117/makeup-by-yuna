class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :appointments
  has_many :clients
end
