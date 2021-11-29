# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/about#show', type: :request do
  path '/api/v1/about' do
    get('show info about the application') do
      tags 'About'
      produces 'application/json'

      security [beboks_registry_auth: []]

      response(200, 'successful') do
        let(:BeboksRegistryToken) { ENV['BEBOKS_REGISTRY_TOKEN'] }

        schema type: :object,
               required: %w[name version],
               properties: {
                 name: { type: 'string' },
                 version: { type: 'string' }
               }

        run_test!
      end
    end
  end
end
