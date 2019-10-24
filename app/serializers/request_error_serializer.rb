class RequestErrorSerializer
  include FastJsonapi::ErrorSerializer

  attributes  :title,
              :detail,
              :code,
              :status

  attribute :source do |err|
    err.serializer_source
  end
end