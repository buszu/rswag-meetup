# frozen_string_literal: true

require 'constants/beboks/moods'
require 'constants/beboks/names'
require 'constants/hearts/colors'

module Beboks
  class CreateContract < Dry::Validation::Contract
    ALLOWED_MOODS = Constants::Beboks::Moods::SAFE_LIST
    NAME_MAX_SIZE = Constants::Beboks::Names::MAX_SIZE

    HEART_COLORS = Constants::Hearts::Colors::LIST

    VIRTUALS = %i[
      heart
    ].freeze

    json do
      required(:name).filled(:string, max_size?: NAME_MAX_SIZE)
      required(:mood).filled(:string, included_in?: ALLOWED_MOODS)

      required(:heart).hash do
        required(:color).filled(:string, included_in?: HEART_COLORS)
        required(:bpm).filled(:integer, gt?: 0)
      end
    end
  end
end
