# frozen_string_literal: true

class HeartBlueprint < Blueprinter::Base
  identifier :id

  fields :color,
         :bpm
end
