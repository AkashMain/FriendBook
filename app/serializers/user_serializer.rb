class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :fname, :full_name
end
