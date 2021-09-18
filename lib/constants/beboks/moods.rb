# frozen_string_literal: true

module Constants
  module Beboks
    class Moods
      ANGRY = 'angry'
      FOCUSED = 'focused'
      SAD = 'sad'
      TRANQUILO = 'tranquilo'

      LIST = [
        ANGRY,
        FOCUSED,
        SAD,
        TRANQUILO
      ].freeze

      SAFE_LIST = LIST - [
        FOCUSED,
        ANGRY
      ].freeze
    end
  end
end
