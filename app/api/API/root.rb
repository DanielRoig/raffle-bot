module API
  class Root < Grape::API
    format :json
    content_type :json, 'application/json; charset=utf-8'

    mount API::V1::Base
  end
end
