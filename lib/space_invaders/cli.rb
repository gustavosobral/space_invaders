# frozen_string_literal: true

require 'thor'

module SpaceInvaders
  # Class responsible for handling the command line interface
  class CLI < Thor
    desc 'analyze SPACE_INVADERS RADAR_IMAGE', 'Analyze RADAR_IMAGE searching for SPACE_INVADERS'
    option :algorithm, type: :string,  aliases: [:a]
    option :threshold, type: :numeric, aliases: [:t]
    option :output,    type: :string,  aliases: [:o]
    def analyze(invaders, radar)
      algorithm = options[:algorithm] ? options[:algorithm].to_sym : :scan
      result = SpaceInvaders::Core::Analyzer.new(invaders: invaders,
                                                 radar: radar,
                                                 algorithm_name: algorithm,
                                                 algorithm_threshold: options[:threshold]).analyze
      handle_output(options[:output], result)
    end

    private

    def handle_output(output_path, result)
      if output_path
        File.write(output_path, "~~~\n" + result + "~~~\n")
      else
        puts result
      end
    end
  end
end
