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

        render json: BebokBlueprint.render(bebok, root: :bebok),
               status: :created
      end

      def update
        contract = Beboks::UpdateContract.new
        validation_result = validate!(contract)

        bebok = Bebok.find(params[:id])
        updater = Beboks::Update.new
        updater.call(bebok, data: validation_result.to_h)

        render json: BebokBlueprint.render(bebok, root: :bebok)
      end

      def destroy
        bebok = Bebok.find(params[:id])
        bebok.destroy

        render json: bebok
      end
    end
  end
end
