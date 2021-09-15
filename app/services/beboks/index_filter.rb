# frozen_string_literal: true

require 'constants/beboks/moods'

module Beboks
  class IndexFilter < Generic::IndexFilter
    MOODS = Constants::Beboks::Moods::LIST

    FILTERS = {
      mood_filter: {
        apply?: ->(params) {
          params[:mood].is_a?(String)
        },
        apply: ->(scope, params) {
          scope.where(mood: params[:mood])
        }
      }.freeze
    }.freeze

    def self.filters
      FILTERS
    end
  end
end
