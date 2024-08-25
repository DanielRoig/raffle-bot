module Service
  extend ActiveSupport::Concern

  included do
    def initialize(params = {})
      define_accessor_methods(params)
    end

    def self.call(*args)
      new(*args).call
    end

    private

    def define_accessor_methods(params)
      params.each { |k, v| send("#{k}=", v) }
    end
  end
end
