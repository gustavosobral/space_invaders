# frozen_string_literal: true

module SpaceInvaders
  module Core
    # Interface abstraction to algorithm strategy pattern
    class AlgorithmStrategy
      attr_reader :space_invader, :radar_image

      def initialize(space_invader, radar_image)
        @space_invader = space_invader
        @radar_image = radar_image
      end

      def process
        raise NotImplementedError, ''
      end
    end
  end
end
