# frozen_string_literal: true

require 'rails_helper'

require 'constants/empty'
require 'constants/beboks/moods'
require 'constants/hearts/colors'

def parse_swagger_schema(name, version: 'v1')
  JSON.parse(File.read("swagger/#{version}/schemas/#{name}.json"))
end

RSpec.configure do |config|
  config.swagger_root = Rails.root.join('swagger').to_s

  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      servers: [
        {
          url: 'http://localhost:3000',
          description: 'Localhost'
        }
      ],
      components: {
        securitySchemes: {
          beboks_registry_auth: {
            type: :apiKey,
            in: :header,
            name: 'BeboksRegistryToken'
          }
        },
        schemas: {
          bebok_schema: parse_swagger_schema('bebok_schema'),
          beboks_schema: parse_swagger_schema('beboks_schema'),
          bebok_moods_enum: {
            type: 'string',
            enum: Constants::Beboks::Moods::LIST
          },
          error_schema: parse_swagger_schema('error_schema'),
          heart_schema: parse_swagger_schema('heart_schema'),
          heart_colors_enum: {
            type: 'string',
            enum: Constants::Hearts::Colors::LIST
          }
        }
      }
    }
  }

  config.swagger_format = :yaml

  config.after do |example|
    next if example.metadata[:example_response] == false ||
            example.metadata[:response].nil? ||
            example.metadata[:operation][:produces].nil? ||
            response.body == Constants::Empty::STRING

    example.metadata[:response][:content] = {
      example.metadata[:operation][:produces].first => {
        schema: respond_to?(:example_schema) ? example_schema : example.metadata[:response][:schema],
        examples: {
          example.metadata[:example_group][:description] => {
            value: JSON.parse(response.body, symbolize_names: true)
          }
        }
      }
    }
  end
end
