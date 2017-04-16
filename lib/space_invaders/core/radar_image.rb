# frozen_string_literal: true

module SpaceInvaders
  module Core
    # Radar image entity
    class RadarImage
      attr_accessor :id, :content

      def initialize(id, content)
        @id = id
        @content = content
      end

      def height
        content.size
      end

      def width
        content.empty? ? 0 : content.first.size
      end

      def content_range(row_range, column_range)
        content[row_range].map { |row| row[column_range] }
      end
    end
  end
end
