# frozen_string_literal: true

require 'constants/beboks/moods'

FactoryBot.define do
  factory :bebok do
    name { 'Maciej' }
    mood { Constants::Beboks::Moods::TRANQUILO }
  end
end
