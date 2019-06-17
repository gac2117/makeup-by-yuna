class ClientSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :extra

  has_many :appointments
  has_many :artists
end
