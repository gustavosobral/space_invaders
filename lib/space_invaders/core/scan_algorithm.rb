# frozen_string_literal: true

module SpaceInvaders
  module Core
    # Implementation of basic Image detection full scan algorithm
    class ScanAlgorithm < AlgorithmStrategy
      def initialize(space_invaders, radar_image, options = {})
        super(space_invaders, radar_image)
        @threshold = options[:threshold] || 0.80
      end

      # Execute the algorithm
      # @return [String]
      #   An image with radar_image dimensions with the space invaders
      #   area indentified on them
      def execute
        similarity_matrices = calculate_similarities

        result = merge_similarities(similarity_matrices)
        format_output(result)
      end

      private

      def calculate_similarities
        space_invaders.map do |space_invader|
          calculate_similarity(space_invader)
        end
      end

      def calculate_similarity(invader)
        similarity_matrix = Array.new(radar_image.height) { Array.new(radar_image.width, 0) }
        radar_row_max_range = (radar_image.height - invader.height)

        radar_image.content[0..radar_row_max_range].each_with_index do |row, row_index|
          radar_column_max_range = (radar_image.width - invader.width + row_index)

          row[row_index..radar_column_max_range].each_with_index do |_, index|
            row_range = (row_index..(invader.height + row_index - 1))
            column_range = (index..(invader.width + index - 1))

            radar_window = radar_image.content_range(row_range, column_range)
            equal_pixels = radar_window.zip(invader.image).map do |x, y|
              x.zip(y).map { |w, z| w == z }
            end
            percentage = equal_pixels.flatten.count(true) / equal_pixels.flatten.size.to_f

            row_range.to_a.each do |i|
              column_range.to_a.each do |j|
                similarity_matrix[i][j] = percentage if similarity_matrix[i][j] < percentage
              end
            end
          end
        end

        similarity_matrix
      end

      def merge_similarities(similarity_matrices)
        output = Array.new(radar_image.height) { Array.new(radar_image.width, '-') }

        similarity_matrices.each_with_index do |similarity_matrix, index|
          similarity_matrix.each_with_index do |row, index_x|
            row.each_with_index do |element, index_y|
              output[index_x][index_y] = space_invaders[index].name if element > @threshold
            end
          end
        end

        output
      end

      def format_output(matrix)
        matrix.map { |row| "#{row.join}\n" }.join
      end
    end
  end
end
