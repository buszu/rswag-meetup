# frozen_string_literal: true

require 'rails_helper'
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
        schemas: {
          bebok_schema: parse_swagger_schema('bebok_schema'),
          beboks_schema: parse_swagger_schema('beboks_schema'),
          bebok_moods_enum: {
            type: 'string',
            enum: Constants::Beboks::Moods::LIST
          },
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
end
