# frozen_string_literal: true

module API
  module V1
    class BeboksController < BaseController
      def index
        scope = Bebok.all
        beboks = Beboks::IndexFilter.new.call(scope, params)

        render json: BebokBlueprint.render(beboks, root: :beboks)
      end

      def create
        contract = Beboks::CreateContract.new
        validation_result = validate!(contract)

        creator = Beboks::Create.new
        bebok = creator.call(data: validation_result.to_h)

        render json: BebokBlueprint.render(bebok, root: :bebok)
      end
    end
  end
end
