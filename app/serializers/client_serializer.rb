class ClientSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :appointments
  has_many :artists
end
