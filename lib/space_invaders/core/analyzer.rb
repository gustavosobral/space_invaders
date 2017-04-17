# frozen_string_literal: true

module SpaceInvaders
  module Core
    class AnalyzerError < StandardError; end

    # Facade to encapsulate the Core subsystems
    class Analyzer
      attr_reader :invaders_model_path, :radar_image_path, :algorithm_name, :algorithm_threshold

      def initialize(options = {})
        @invaders_model_path = options[:invaders]
        @radar_image_path    = options[:radar]
        @algorithm_name      = options[:algorithm_name]
        @algorithm_threshold = options[:algorithm_threshold]
      end

      def analyze
        algorithm = select_algorithm
        space_invaders, radar_images = read_files
        call_algorithm(algorithm, space_invaders, radar_images.first)
      end

      private

      def select_algorithm
        case algorithm_name
        when :scan
          ScanAlgorithm
        else
          raise AnalyzerError, 'Invalid algorithm selected'
        end
      end

      def read_files
        invaders_images = FileParser.new(invaders_model_path).process
        space_invaders = invaders_images.each_with_index.map do |invader_image, index|
          SpaceInvader.new(index + 1, invader_image)
        end

        radar_content = FileParser.new(radar_image_path).process
        radar_images = radar_content.each_with_index.map do |image, index|
          RadarImage.new("Radar Image ##{index + 1}", image)
        end

        return space_invaders, radar_images
      end

      def call_algorithm(algorithm, invaders, image)
        algorithm.new(invaders, image, threshold: algorithm_threshold).execute
      end
    end
  end
end
