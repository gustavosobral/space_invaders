# frozen_string_literal: true

describe SpaceInvaders::Core::SpaceInvader do
  subject do
    SpaceInvaders::Core::SpaceInvader.new('Invader #1',
                                          [['o', '-', '-', 'o'],
                                           ['o', 'o', 'o', 'o'],
                                           ['-', 'o', 'o', '-']])
  end

  it 'has height and width' do
    space_invader = SpaceInvaders::Core::SpaceInvader.new('', [])
    expect(space_invader.height).to eq(0)
    expect(space_invader.width).to eq(0)
  end

  it 'has a name' do
    expect(subject.name).to eq('Invader #1')
  end

  it 'has valid properties' do
    expect(subject.name).to eq('Invader #1')
    expect(subject.height).to eq(3)
    expect(subject.width).to eq(4)
  end

  it 'has a string representation' do
    expect(subject.to_s).to eq("o--o\noooo\n-oo-\n")
  end
end
