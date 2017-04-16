# frozen_string_literal: true

describe SpaceInvaders::Core::ScanAlgorithm do
  it 'Implement execute method' do
    scan_algorithm = SpaceInvaders::Core::ScanAlgorithm.new(nil, nil)
    expect(scan_algorithm).to respond_to(:execute)
  end

  it 'Has a valid output' do
    space_invaders = SpaceInvaders::Core::FileParser.new('spec/fixtures/space_invaders').process.each_with_index.map do |invader, index|
      SpaceInvaders::Core::SpaceInvader.new(index + 1, invader)
    end

    image = SpaceInvaders::Core::FileParser.new('spec/fixtures/radar_image').process.first
    radar_image = SpaceInvaders::Core::RadarImage.new("Radar Image #1", image)

    algorithm_result = SpaceInvaders::Core::ScanAlgorithm.new(space_invaders, radar_image, threshold: 0.8).execute
    reference = File.read('spec/fixtures/radar_image_full_scan_80')
    expect(algorithm_result).to eq(reference)
  end
end
