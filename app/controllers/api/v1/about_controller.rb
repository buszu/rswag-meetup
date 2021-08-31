# frozen_string_literal: true

module API
  module V1
    class AboutController < BaseController
      ABOUT = About.new(
        name: 'Rswag Meetup: Example Project',
        version: '0.0.0'
      ).freeze

      def show
        render json: AboutBlueprint.render(ABOUT)
      end
    end
  end
end
