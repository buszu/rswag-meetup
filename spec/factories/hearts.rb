# frozen_string_literal: true

require 'constants/hearts/colors'

FactoryBot.define do
  factory :heart do
    bebok { nil }
    color { Comstanst::Hearts::Colors::GAMMA }
    bpm { 45 }
  end
end
