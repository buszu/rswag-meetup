# frozen_string_literal: true

require 'constants/hearts/colors'

FactoryBot.define do
  factory :heart do
    bebok { nil }
    color { Constants::Hearts::Colors::GAMMA }
    bpm { 45 }
  end
end
