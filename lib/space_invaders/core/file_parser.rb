# frozen_string_literal: true

module SpaceInvaders
  module Core
    # Read and parse the input files
    class FileParser
      attr_reader :path

      def initialize(path)
        @path = path
      end

      # Process the file on path
      # @return [Array] An Array of entities (Space invaders or radar images) as matrices of data
      def process
        @entities = []
        @marker_found = false
        read_lines
        @entities
      end

      private

      def read_lines
        File.readlines(@path).each do |line|
          if line.strip == '~~~~'
            @marker_found = !@marker_found
            treat_entity
            next
          end
          @entity << line.strip.split('') if @marker_found
        end
      end

      def treat_entity
        if @marker_found
          new_entity
        else
          insert_entity
        end
      end

      def new_entity
        @entity = []
      end

      def insert_entity
        @entities << @entity
      end
    end
  end
end
