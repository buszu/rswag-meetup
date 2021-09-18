# frozen_string_literal: true

module Beboks
  class Create
    def call(data:)
      transaction do
        bebok = Bebok.create(data.except(*virtuals))
        bebok.create_heart(data[:heart])

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
