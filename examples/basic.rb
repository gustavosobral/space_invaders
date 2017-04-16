# frozen_string_literal: true

require_relative '../lib/space_invaders'

SpaceInvaders::Core::Analyzer.new(invaders: 'spec/fixtures/space_invaders',
                                  radar: 'spec/fixtures/radar_image',
                                  algorithm_name: :scan).analyze
