# frozen_string_literal: true

module SpaceInvaders
  module Core
    # Radar image entity
    class RadarImage
      attr_accessor :id, :content

      def initialize(id, content)
        @id      = id
        @content = content
      end

      # The radar image content height.
      #
      # @return [Integer]
      #   The content height
      def height
        content.size
      end

      # The radar image content width.
      #
      # @return [Integer]
      #   The content width
      def width
        content.empty? ? 0 : content.first.size
      end

      # Get the radar image content between two ranges.
      #
      # @param row_range [Range]
      # @param column_range [Range]
      #
      # @return [Array<Array<String>>]
      #   The content between the two ranges
      def content_range(row_range, column_range)
        content[row_range].map { |row| row[column_range] }
      end
    end
  end
end
