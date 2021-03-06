# frozen_string_literal: true

describe SpaceInvaders::CLI do
  it 'fail with no aguments' do
    expect do
      subject.analyze
    end.to raise_error(ArgumentError)
  end

  it 'works with no flags' do
    output = capture(:stdout) do
      subject.analyze('spec/fixtures/space_invaders', 'spec/fixtures/radar_image')
    end
    reference = File.read('spec/fixtures/radar_image_full_scan_80')
    expect(output).to eq(reference)
  end

  it 'accept algorithm threshold flag' do
    subject.options = { threshold: 0.85 }

    output = capture(:stdout) do
      subject.analyze('spec/fixtures/space_invaders', 'spec/fixtures/radar_image')
    end
    reference = File.read('spec/fixtures/radar_image_full_scan_85')
    expect(output).to eq(reference)
  end

  it 'can write output to a file' do
    fixtures = File.expand_path('../fixtures', __FILE__)
    FakeFS::FileSystem.clone(fixtures)

    subject.options = { output: 'output_path' }

    FakeFS do
      subject.analyze("#{fixtures}/space_invaders", "#{fixtures}/space_invaders")
      expect(File.exist?('output_path')).to be true
    end
  end

  it 'fail with wrong algorithm option' do
    subject.options = { algorithm: :invalid }

    expect do
      capture(:stderr) do
        subject.analyze('spec/fixtures/space_invaders', 'spec/fixtures/radar_image')
      end
    end.to raise_error(SystemExit)
  end
end
