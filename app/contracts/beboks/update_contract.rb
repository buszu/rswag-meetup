# frozen_string_literal: true

require 'constants/beboks/moods'
require 'constants/beboks/names'
require 'constants/hearts/colors'

module Beboks
  class UpdateContract < Dry::Validation::Contract
    ALLOWED_MOODS = Constants::Beboks::Moods::SAFE_LIST
    NAME_MAX_SIZE = Constants::Beboks::Names::MAX_SIZE

    HEART_COLORS = Constants::Hearts::Colors::LIST

    VIRTUALS = %i[
      heart
    ].freeze

    json do
      optional(:name).filled(:string, max_size?: NAME_MAX_SIZE)
      optional(:mood).filled(:string, included_in?: ALLOWED_MOODS)

      optional(:heart).filled(:hash) do
        optional(:color).filled(:string, included_in?: HEART_COLORS)
        optional(:bpm).filled(:integer, gt?: 0)
      end
    end
  end
end
