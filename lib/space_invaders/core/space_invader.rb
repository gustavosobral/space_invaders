# frozen_string_literal: true

module SpaceInvaders
  module Core
    # Space invader entity
    class SpaceInvader
      attr_accessor :name, :image

      def initialize(name, image)
        @name  = name
        @image = image
      end

      # The space invader image height.
      #
      # @return [Integer] Invader image height
      def height
        image.size
      end

      # The space invader image width.
      #
      # @return [Integer] Invader image width
      def width
        image.empty? ? 0 : image.first.size
      end

      # String representation of invader image.
      #
      # @return [String] Invader image representation
      def to_s
        image.map { |row| "#{row.join}\n" }.join
      end
    end
  end
end
