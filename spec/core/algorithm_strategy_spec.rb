# frozen_string_literal: true

describe SpaceInvaders::Core::AlgorithmStrategy do
  it 'Raise NotImplemented if tried to be used' do
    expect do
      SpaceInvaders::Core::AlgorithmStrategy.new(nil, nil).execute
    end.to raise_error(NotImplementedError)
  end
end
