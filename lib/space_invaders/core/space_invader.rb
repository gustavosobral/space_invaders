# frozen_string_literal: true

module SpaceInvaders
  module Core
    # Space invader entity
    class SpaceInvader
      attr_accessor :name, :image

      def initialize(name, image)
        @name = name
        @image = image
      end

      def height
        image.size
      end

      def width
        image.empty? ? 0 : image.first.size
      end

      def to_s
        image.map { |row| "#{row.join}\n" }.join
      end
    end
  end
end
