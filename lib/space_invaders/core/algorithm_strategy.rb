# frozen_string_literal: true

module SpaceInvaders
  module Core
    # Interface abstraction to algorithm strategy pattern
    class AlgorithmStrategy
      attr_reader :space_invaders, :radar_image

      def initialize(space_invaders, radar_image, _options = {})
        @space_invaders = space_invaders
        @radar_image = radar_image
      end

      def execute
        raise NotImplementedError, ''
      end
    end
  end
end
