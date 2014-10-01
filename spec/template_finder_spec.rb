require 'spec_helper'

describe Liftoff::TemplateFinder do
  describe '#template_path' do
    let (:finder) { described_class.new }

    it 'returns the local file if it exists' do
      expect(File).to receive(:exists?).with(local_file('local')) { true }

      expect(finder.template_path('local')).to eq local_file('local')
    end

    it 'returns the user file if it exists' do
      expect(File).to receive(:exists?).with(user_file('user')) { true }
      expect(File).to receive(:exists?).with(local_file('user')) { false }

      expect(finder.template_path('user')).to eq user_file('user')
    end

    it 'returns the default template if there is no local or user template' do
      expect(File).to receive(:exists?).with(user_file('default')) { false }
      expect(File).to receive(:exists?).with(local_file('default')) { false }

      expect(finder.template_path('default')).to eq default_file('default')
    end
  end

  def local_file(name)
    File.join(File.expand_path('..'), '.liftoff', 'templates', name)
  end

  def user_file(name)
    File.join(ENV['HOME'], '.liftoff', 'templates', name)
  end

  def default_file(name)
    File.join(File.expand_path('../../templates', __FILE__), name)
  end
end
