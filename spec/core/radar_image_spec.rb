# frozen_string_literal: true

describe SpaceInvaders::Core::RadarImage do
  subject do
    SpaceInvaders::Core::RadarImage.new('#1',
                                        [['o', '-', '-', 'o', 'o', '-'],
                                         ['o', 'o', 'o', 'o', '-', '-'],
                                         ['-', 'o', 'o', '-', 'o', '-'],
                                         ['o', '-', '-', '-', 'o', '-']])
  end

  it 'Has height and width' do
    space_invader = SpaceInvaders::Core::RadarImage.new('', [])
    expect(space_invader.height).to eq(0)
    expect(space_invader.width).to eq(0)
  end

  it 'Has a identifier' do
    expect(subject.id).to eq('#1')
  end

  it 'Valid properties' do
    expect(subject.id).to eq('#1')
    expect(subject.height).to eq(4)
    expect(subject.width).to eq(6)
  end

  it 'Subset your content' do
    expect(subject.content_range(1..2, 3..4)).to eq([['o', '-'], ['-', 'o']])
  end
end
