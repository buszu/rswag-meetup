# frozen_string_literal: true

require 'swagger_helper'
require 'constants/beboks/moods'
require 'constants/hearts/colors'

RSpec.describe 'api/v1/beboks#update', type: :request do
  path '/api/v1/beboks/{id}' do
    patch('update bebok data') do
      tags 'Beboks'

      security [beboks_registry_auth: []]

      consumes 'application/json'
      produces 'application/json'

      parameter name: :id,
                in: :path,
                description: 'ID of the bebok that will be updated',
                schema: {
                  type: 'integer'
                }

      parameter name: :input,
                in: :body,
                schema: {
                  type: 'object',
                  properties: {
                    name: {
                      type: 'string',
                      minLength: 1,
                      maxLength: Beboks::UpdateContract::NAME_MAX_SIZE
                    },
                    mood: {
                      type: 'string',
                      enum: Beboks::UpdateContract::ALLOWED_MOODS
                    },
                    heart: {
                      type: 'object',
                      required: %w[color bpm],
                      properties: {
                        color: {
                          type: 'string',
                          enum: Beboks::UpdateContract::HEART_COLORS
                        },
                        bpm: {
                          type: 'integer',
                          minimum: 1
                        }
                      }
                    }
                  }
                }

      response(200, 'updated') do
        schema '$ref': '#/components/schemas/bebok_schema'

        let!(:heart) { create(:heart, bebok: bebok) }
        let(:bebok) { create(:bebok) }

        let(:BeboksRegistryToken) { ENV['BEBOKS_REGISTRY_TOKEN'] }
        let(:id) { bebok.id }
        let(:input) do
          {
            name: 'updated bebok',
            mood: Constants::Beboks::Moods::SAD,
            heart: {
              bpm: 120,
              color: Constants::Hearts::Colors::BLUE
            }
          }
        end

        run_test!
      end

      response(404, 'not found') do
        schema '$ref': '#/components/schemas/error_schema'

        let(:BeboksRegistryToken) { ENV['BEBOKS_REGISTRY_TOKEN'] }
        let(:id) { 1 }
        let(:input) { {} }

        let(:expected_error) do
          I18n.t!('errors.api.not_found.model_by', klass: 'Bebok', by: :id, value: id)
        end

        run_test! do |response|
          error = JSON.parse(response.body)['error']
          expect(error).to eq(expected_error)
        end
      end
    end
  end
end
