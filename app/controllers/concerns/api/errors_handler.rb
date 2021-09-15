# frozen_string_literal: true

module API
  module ErrorsHandler
    extend ActiveSupport::Concern

    included do
      rescue_from Controllers::Errors::API::BaseError, with: :handle_api_error
      rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
    end

    private

    def validation_failed!(validation_result)
      raise Controllers::Errors::API::ValidationFailed, validation_result.errors.to_h
    end

    def handle_not_found(error)
      message = if error.id.nil?
                  I18n.t('errors.api.not_found.model', klass: error.model)
                else
                  I18n.t('errors.api.not_found.model_by', klass: error.model, by: :id, value: error.id)
                end

      not_found = Controllers::Errors::API::NotFound.new(message)
      handle_api_error(not_found)
    end

    def handle_api_error(error)
      serialized_error =
        case error
        when Controllers::Errors::API::ValidationFailed
          { error: error.message, details: error.details }
        else
          { error: error.message }
        end

      render json: serialized_error, status: error.status
    end
  end
end
