# frozen_string_literal: true

require 'swagger_helper'
require 'constants/beboks/moods'
require 'constants/hearts/colors'

RSpec.describe 'api/v1/beboks#create', type: :request do
  path '/api/v1/beboks' do
    post('add a bebok to registry') do
      tags 'Beboks'

      consumes 'application/json'
      produces 'application/json'

      parameter name: :input,
          in: :body,
          schema: {
            type: 'object',
            required: %w[name mood heart],
            properties: {
              name: {
                type: 'string',
                minLength: 1,
                maxLength: Beboks::CreateContract::NAME_MAX_SIZE
              },
              mood: {
                type: 'string',
                enum: Beboks::CreateContract::ALLOWED_MOODS
              },
              heart: {
                type: 'object',
                required: %w[color bpm],
                properties: {
                  color: {
                    type: 'string',
                    enum: Beboks::CreateContract::HEART_COLORS
                  },
                  bpm: {
                    type: 'integer',
                    minimum: 1
                  }
                }
              }
            }
          }

      response(201, 'created') do
        schema '$ref': '#/components/schemas/bebok_schema'

        let(:input) {
          attributes_for(:bebok).slice(:name, :mood).merge(
            heart: attributes_for(:heart).slice(:color, :bpm)
          )
        }

        run_test!
      end
    end
  end
end
