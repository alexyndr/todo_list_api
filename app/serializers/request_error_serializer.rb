# frozen_string_literal: true

class RequestErrorSerializer
  include FastJsonapi::ErrorSerializer

  attributes  :title,
              :detail,
              :code,
              :status

  attribute :source, &:serializer_source
end
