# frozen_string_literal: true

class Bebok < ApplicationRecord
  has_one :heart, dependent: :destroy
end
