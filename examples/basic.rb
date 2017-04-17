# frozen_string_literal: true

SpaceInvaders::Core::Analyzer.new(invaders: 'spec/fixtures/space_invaders',
                                  radar: 'spec/fixtures/radar_image',
                                  algorithm_name: :scan).analyze
