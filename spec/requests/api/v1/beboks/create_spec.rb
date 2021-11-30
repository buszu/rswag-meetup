# frozen_string_literal: true

require 'swagger_helper'
require 'constants/beboks/moods'
require 'constants/hearts/colors'

RSpec.describe 'api/v1/beboks#create', type: :request do
  path '/api/v1/beboks' do
    post('add a bebok to registry') do
      tags 'Beboks'

      security [beboks_registry_auth: []]

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
                      example: 'Bebok Niebieski',
                      minLength: 1,
                      maxLength: Beboks::CreateContract::NAME_MAX_SIZE
                    },
                    mood: {
                      example: Constants::Beboks::Moods::TRANQUILO,
                      type: 'string',
                      enum: Beboks::CreateContract::ALLOWED_MOODS
                    },
                    heart: {
                      type: 'object',
                      required: %w[color bpm],
                      properties: {
                        color: {
                          example: Constants::Hearts::Colors::BLUE,
                          type: 'string',
                          enum: Beboks::CreateContract::HEART_COLORS
                        },
                        bpm: {
                          example: 50,
                          type: 'integer',
                          minimum: 1
                        }
                      }
                    }
                  }
                }

      response(201, 'created') do
        schema '$ref': '#/components/schemas/bebok_schema'

        let(:BeboksRegistryToken) { ENV['BEBOKS_REGISTRY_TOKEN'] }

        let(:input) do
          attributes_for(:bebok).slice(:name, :mood).merge(
            heart: attributes_for(:heart).slice(:color, :bpm)
          )
        end

        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:BeboksRegistryToken) { ENV['BEBOKS_REGISTRY_TOKEN'] }

        let(:valid_input) do
          attributes_for(:bebok).slice(:name, :mood).merge(
            heart: attributes_for(:heart).slice(:color, :bpm)
          )
        end

        it_behaves_like 'invalid field', description: 'when name is too long' do
          let(:key) { [:name] }
          let(:limit) { Beboks::CreateContract::NAME_MAX_SIZE }
          let(:value) { 'x' * limit.succ }
          let(:key_message) { "size cannot be greater than #{limit}" }
        end

        it_behaves_like 'invalid field', description: 'when heart color is unsupported' do
          let(:key) { %i[heart color] }
          let(:allowed_values) { Beboks::CreateContract::HEART_COLORS }
          let(:value) { 'green' }
          let(:key_message) { "must be one of: #{allowed_values.join(', ')}" }
        end
      end
    end
  end
end
