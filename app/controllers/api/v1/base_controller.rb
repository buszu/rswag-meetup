# frozen_string_literal: true

module API
  module V1
    class BaseController < ActionController::API
      include ErrorsHandler

      private

      def validate!(contract)
        result = contract.call(params.to_unsafe_h)
        raise Controllers::Errors::API::ValidationFailed, result.errors.to_h if result.failure?

        result
      end
    end
  end
end
