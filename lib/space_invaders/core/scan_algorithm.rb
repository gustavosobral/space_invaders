# frozen_string_literal: true

module SpaceInvaders
  module Core
    # Implementation of Image detection full scan algorithm
    class ScanAlgorithm < AlgorithmStrategy
      def initialize(space_invaders, radar_image, options = {})
        super(space_invaders, radar_image)
        @threshold        = options[:threshold] || 0.80
        @border_character = 'x'
      end

      # Execute the algorithm.
      #
      # @return [String]
      #   An image with radar image dimensions with the space invaders
      #   area indentified on them
      def execute
        border_height, border_width = border_calculations
        new_image = new_bordered_image(border_height, border_width, @border_character)
        bordered_image = apply_border(border_height, border_width, new_image)

        similarity_matrices = space_invaders.map do |space_invader|
          ScanAlgorithmSimilarity.new(space_invader, @border_character, bordered_image).calculate
        end

        result = merge_similarities(similarity_matrices, border_height, border_width)
        format_output(result)
      end

      private

      # Calculate the border properties (height and width)
      def border_calculations
        border_height = (space_invaders.max_by(&:height).height / 2.0).round
        border_width = (space_invaders.max_by(&:width).width / 2.0).round

        return border_height, border_width
      end

      # Create a new full bordered image
      def new_bordered_image(border_height, border_width, border)
        Array.new(radar_image.height + (border_height * 2)) do
          Array.new(radar_image.width + (border_width * 2), border)
        end
      end

      # Apply border on the radar image
      #
      # @return [RadarImage]
      #   A new radar image bordered
      def apply_border(border_height, border_width, bordered_image)
        radar_image.content[0..radar_image.height].each_with_index do |row, row_index|
          width_range = border_width..(border_width + radar_image.width - 1)
          bordered_image[border_height + row_index][width_range] = row
        end

        RadarImage.new(radar_image.id, bordered_image)
      end

      # Merge the similarity between the similarity matrices
      # ignoring the border
      def merge_similarities(similarity_matrices, border_height, border_width)
        output = Array.new(radar_image.height) { Array.new(radar_image.width, '-') }

        similarity_matrices.each_with_index do |similarity_matrix, index|
          subset = similarity_subset(similarity_matrix, border_height, border_width)

          subset.each_with_index do |row, index_x|
            row.each_with_index do |element, index_y|
              output[index_x][index_y] = space_invaders[index].name if element > @threshold
            end
          end
        end

        output
      end

      # Subset the similarity matrix ignoring the borders values
      def similarity_subset(similarity_matrix, border_height, border_width)
        max_range = (radar_image.height + border_height - 1)
        similarity_matrix[border_height..max_range].map do |row|
          row[border_width..(radar_image.width + border_width - 1)]
        end
      end

      def format_output(matrix)
        matrix.map { |row| "#{row.join}\n" }.join
      end
    end
  end
end
