# frozen_string_literal: true

describe SpaceInvaders::Core::ScanAlgorithmSimilarity do
  it 'match with last invader similarity' do
    invaders_file = SpaceInvaders::Core::FileParser.new('spec/fixtures/space_invaders')
    invader = SpaceInvaders::Core::SpaceInvader.new(1, invaders_file.process.last)

    image = SpaceInvaders::Core::FileParser.new('spec/fixtures/bordered_radar_image').process.first
    bordered_image = SpaceInvaders::Core::RadarImage.new('Bordered Image #1', image)

    similarity = SpaceInvaders::Core::ScanAlgorithmSimilarity.new(invader,
                                                                  'x',
                                                                  bordered_image).calculate
    expect(similarity[4][24..31]).to eq([0.8035714285714286, 0.8035714285714286,
                                         0.8035714285714286, 0.8035714285714286,
                                         0.8035714285714286, 0.8035714285714286,
                                         0.8035714285714286, 0.8035714285714286])
  end
end
