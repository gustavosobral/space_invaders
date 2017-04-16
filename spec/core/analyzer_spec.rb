# frozen_string_literal: true

describe SpaceInvaders::Core::Analyzer do
  it 'Load files and execute algorithm properly' do
    analyzer_result = SpaceInvaders::Core::Analyzer.new(invaders: 'spec/fixtures/space_invaders',
                                                        radar: 'spec/fixtures/radar_image',
                                                        algorithm_name: :scan).analyze
    reference = File.read('spec/fixtures/radar_image_full_scan_80')
    expect(analyzer_result).to eq(reference)
  end

  it 'Receive the chosen algorithm threshold' do
    analyzer_result = SpaceInvaders::Core::Analyzer.new(invaders: 'spec/fixtures/space_invaders',
                                                        radar: 'spec/fixtures/radar_image',
                                                        algorithm_name: :scan,
                                                        algorithm_threshold: 0.85).analyze
    reference = File.read('spec/fixtures/radar_image_full_scan_85')
    expect(analyzer_result).to eq(reference)
  end

  it 'Raise exception if a invalid algorithm is selected' do
    expect do
      SpaceInvaders::Core::Analyzer.new(algorithm_name: :scam).analyze
    end.to raise_error(SpaceInvaders::Core::AnalyzerError)
  end
end
