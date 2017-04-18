# frozen_string_literal: true

module SpaceInvaders
  module Core
    # Interface abstraction to algorithms (Strategy pattern)
    class AlgorithmStrategy
      attr_reader :space_invaders, :radar_image

      def initialize(space_invaders, radar_image, _options = {})
        @space_invaders = space_invaders
        @radar_image    = radar_image
      end

      # Strategy interface method.
      def execute
        raise NotImplementedError, ''
      end
    end
  end
end
