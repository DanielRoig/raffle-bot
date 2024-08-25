class ErrorHandler
  ERRORS = {
    'API::Exceptions::InvalidToken' => lambda do |_error|
      {
        code: 'invalid_token',
        message: 'The access token is invalid',
        http_status: 401,
        level: :info
      }
    end,
    'API::Exceptions::InvalidContext' => lambda do |_error|
      {
        code: 'invalid_context',
        message: 'Developer attempted an operation that needs user context',
        http_status: 403,
        level: :warning
      }
    end,
    'API::Exceptions::InvalidOperation' => lambda do |_error|
      {
        code: 'invalid_operation',
        message: 'Developer attempted an operation rails_api_boilerplate does not allow',
        http_status: 404,
        level: :warning
      }
    end,
    'API::Exceptions::ResourceNotFound' => lambda do |_error|
      {
        code: 'resource_not_found',
        message: 'Resource with given id not found',
        http_status: 404,
        level: :warning
      }
    end,
    'Grape::Exceptions::ValidationErrors' => lambda do |_error|
      {
        code: 'invalid_params',
        message: 'Missing required parameters',
        http_status: 422,
        level: :warning
      }
    end
  }.freeze

  DEFAULT_ERROR = lambda do |_error|
    {
      code: 'unknown_exception',
      message: 'rails_api_boilerplate unknown issue',
      http_status: 500,
      level: :error
    }
  end

  def initialize(app)
    @app = app
  end

  def call(env)
    @app.call(env)
  rescue StandardError => e
    error_type = ERRORS.fetch(e.class.name, DEFAULT_ERROR).call(e)

    error_body = {
      error: {
        code: error_type[:code],
        message: error_type[:message]
      }
    }
    error_body[:error][:inner_error] = e.message if Rails.env.test?
    rack_response(error_body.to_json, error_type[:http_status])
  end

  private

  def rack_response(message,
                    status = options[:default_status],
                    headers = { 'Content-Type' => 'application/json' })
    Rack::Response.new([message], status, headers).finish
  end
end
