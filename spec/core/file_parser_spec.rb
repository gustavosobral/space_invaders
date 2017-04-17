# frozen_string_literal: true

describe SpaceInvaders::Core::FileParser do
  it 'raise error with invalid path' do
    expect do
      SpaceInvaders::Core::FileParser.new('invalid/path').process
    end.to raise_error(Errno::ENOENT)
  end

  it 'return an array of space invaders' do
    file_content = SpaceInvaders::Core::FileParser.new('spec/fixtures/space_invaders').process
    expect(file_content.first).to eq([['-', '-', 'o', '-', '-', '-', '-', '-', 'o', '-', '-'],
                                      ['-', '-', '-', 'o', '-', '-', '-', 'o', '-', '-', '-'],
                                      ['-', '-', 'o', 'o', 'o', 'o', 'o', 'o', 'o', '-', '-'],
                                      ['-', 'o', 'o', '-', 'o', 'o', 'o', '-', 'o', 'o', '-'],
                                      ['o', 'o', 'o', 'o', 'o', 'o', 'o', 'o', 'o', 'o', 'o'],
                                      ['o', '-', 'o', 'o', 'o', 'o', 'o', 'o', 'o', '-', 'o'],
                                      ['o', '-', 'o', '-', '-', '-', '-', '-', 'o', '-', 'o'],
                                      ['-', '-', '-', 'o', 'o', '-', 'o', 'o', '-', '-', '-']])

    expect(file_content.last).to include(['o', 'o', '-', 'o', 'o', '-', 'o', 'o'])
  end

  it 'return an array of radar images' do
    file_content = SpaceInvaders::Core::FileParser.new('spec/fixtures/radar_image').process
    expect(file_content.first).to include(['-', '-', '-', '-', 'o', '-', '-', 'o', 'o', '-',
                                           '-', '-', '-', 'o', '-', '-', 'o', 'o', 'o', '-',
                                           '-', 'o', 'o', 'o', '-', '-', '-', '-', '-', '-',
                                           '-', '-', '-', 'o', '-', '-', '-', 'o', 'o', '-',
                                           'o', '-', '-', '-', '-', 'o', 'o', '-', '-', '-',
                                           'o', '-', '-', 'o', '-', '-', '-', '-', '-', '-',
                                           '-', '-', '-', 'o', '-', '-', '-', '-', 'o', '-',
                                           '-', '-', '-', '-', '-', 'o', '-', '-', '-', '-',
                                           '-', '-', '-', '-', '-', '-', '-', '-', '-', '-',
                                           '-', '-', 'o', '-', '-', 'o', '-', '-', 'o', '-'])
  end
end
