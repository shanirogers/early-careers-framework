module API
  module V1
    class SerializableProvider < JSONAPI::Serializable::Resource
      type "providers"

      attributes :provider_code, :provider_name, :provider_type,
                 :latitude, :longitude

    end
  end
end
