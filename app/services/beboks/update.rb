# frozen_string_literal: true

require 'constants/empty'

module Beboks
  class Update
    EMPTY_HASH = Constants::Empty::HASH

    def call(bebok, data:)
      transaction do
        bebok.update(data.except(*virtuals))
        bebok.heart.update(data.fetch(:heart, EMPTY_HASH))

        bebok
      end
    end

    private

    delegate :transaction, to: :ApplicationRecord, private: true

    def virtuals
      CreateContract::VIRTUALS
    end
  end
end
