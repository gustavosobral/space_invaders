# frozen_string_literal: true

module SpaceInvaders
  module Core
    # Implementation of basic Image detection full scan algorithm
    class ScanAlgorithm < AlgorithmStrategy
      def initialize(space_invaders, radar_image, options = {})
        super(space_invaders, radar_image)
        @threshold = options[:threshold] || 0.80
      end

      # Execute the algorithm.
      #
      # @return [String]
      #   An image with radar image dimensions with the space invaders
      #   area indentified on them
      def execute
        border_height, border_width = border_calculations
        bordered_image = apply_border(border_height, border_width, 'x')

        similarity_matrices = space_invaders.map do |space_invader|
          calculate_similarity(space_invader, bordered_image)
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

      # Apply border on the radar image
      #
      # @return [RadarImage]
      #   The new radar image bordered
      def apply_border(border_height, border_width, border)
        bordered_image = Array.new(radar_image.height + (border_height * 2)) do
          Array.new(radar_image.width + (border_width * 2), border)
        end

        radar_image.content[0..radar_image.height].each_with_index do |row, row_index|
          width_range = border_width..(border_width + radar_image.width - 1)
          bordered_image[border_height + row_index][width_range] = row
        end

        RadarImage.new(radar_image.id, bordered_image)
      end

      # Calculate the similarity matrix between the
      # bordered radar image and the space invader
      def calculate_similarity(invader, bordered_image)
        similarity_matrix = Array.new(bordered_image.height) { Array.new(bordered_image.width, 0) }

        max_row_index = (bordered_image.height - invader.height)
        max_column_index = (bordered_image.width - invader.width)

        bordered_image.content[0..max_row_index].each_with_index do |row, row_index|
          row[0..max_column_index].each_with_index do |_, index|
            row_range, column_range = calculate_window_range(row_index, index, invader)
            radar_window = bordered_image.content_range(row_range, column_range)
            similarity = window_similarity(invader, radar_window)
            update_similarity(similarity_matrix, similarity, row_range, column_range) if similarity
          end
        end

        similarity_matrix
      end

      # Calculate the range of radar image window under comparison
      def calculate_window_range(row_index, index, invader)
        row_range = (row_index..(invader.height + row_index - 1))
        column_range = (index..(invader.width + index - 1))

        return row_range, column_range
      end

      def window_similarity(invader, radar_window)
        return unless radar_window.flatten.count('x') < (radar_window.flatten.size / 2.0)
        window_comparison(radar_window, invader)
      end

      # Calculate the percentage of similiratiry between the
      # space invader and the radar window (Ignore border indexes)
      #
      # @return [Float]
      #   The percentage similarity
      def window_comparison(radar_window, invader)
        equal_pixels = radar_window.zip(invader.image).map do |x, y|
          x.zip(y).map do |w, z|
            w == z if w != 'x'
          end
        end

        equal_pixels = equal_pixels.flatten.compact
        equal_pixels.count(true) / equal_pixels.size.to_f
      end

      # Update the similarity matrix with the new similarity
      def update_similarity(similarity_matrix, similarity, row_range, column_range)
        row_range.to_a.each do |i|
          column_range.to_a.each do |j|
            similarity_matrix[i][j] = similarity if similarity_matrix[i][j] < similarity
          end
        end
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
