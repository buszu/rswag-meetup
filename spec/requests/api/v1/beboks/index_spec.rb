# frozen_string_literal: true

require 'swagger_helper'
require 'constants/beboks/moods'

RSpec.describe 'api/v1/beboks#index', type: :request do
  path '/api/v1/beboks' do
    get('list beboks') do
      tags 'Beboks'

      security [beboks_registry_auth: []]

      produces 'application/json'

      parameter name: :mood,
                required: false,
                in: :query,
                schema: {
                  type: 'string',
                  enum: Constants::Beboks::Moods::LIST
                }

      response(200, 'successful') do
        schema '$ref': '#/components/schemas/beboks_schema'

        let(:BeboksRegistryToken) { ENV['BEBOKS_REGISTRY_TOKEN'] }

        run_test!
      end
    end
  end
end
