# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/beboks#destroy', type: :request do
  path '/api/v1/beboks/{id}' do
    delete('delete bebok data') do
      tags 'Beboks'

      produces 'application/json'

      parameter name: :id,
                in: :path,
                description: 'ID of the bebok data to be deleted',
                schema: {
                  type: 'integer'
                }

      response(204, 'successful') do
        let!(:heart) { create(:heart, bebok: bebok) }
        let(:bebok) { create(:bebok) }

        let(:id) { bebok.id }

        run_test!
      end

      response(404, 'not found') do
        schema '$ref': '#/components/schemas/error_schema'

        let(:id) { 1 }

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
