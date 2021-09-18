# frozen_string_literal: true

require 'constants/beboks/moods'

FactoryBot.define do
  factory :bebok do
    name { 'Bebok jeden' }
    mood { 'happy' }
  end
end
