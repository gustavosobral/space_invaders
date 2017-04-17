# frozen_string_literal: true

# Full scan algorithm with threshold parameter
SpaceInvaders::Core::Analyzer.new(invaders: 'spec/fixtures/space_invaders',
                                  radar: 'spec/fixtures/radar_image',
                                  algorithm_name: :scan,
                                  algorithm_threshold: 0.85).analyze
