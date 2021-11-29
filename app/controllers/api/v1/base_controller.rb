# frozen_string_literal: true

module API
  module V1
    class BaseController < ActionController::API
      include ErrorsHandler

      before_action :authorize!

      private

      def validate!(contract)
        result = contract.call(params.to_unsafe_h)
        raise Controllers::Errors::API::ValidationFailed, result.errors.to_h if result.failure?

        result
      end

      def authorize!
        authorized = request.headers['BeboksRegistryToken'] == ENV['BEBOKS_REGISTRY_TOKEN']
        raise Controllers::Errors::API::Unauthorized unless authorized
      end
    end
  end
end
