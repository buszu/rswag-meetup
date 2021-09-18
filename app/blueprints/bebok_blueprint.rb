# frozen_string_literal: true

class BebokBlueprint < Blueprinter::Base
  identifier :id

  fields :name,
         :mood

  association :heart, blueprint: HeartBlueprint
end
