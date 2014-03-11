require 'spec_helper'

describe Liftoff::ProjectConfiguration do
  describe '#company_identifier' do
    context 'when the identifier is set directly' do
      it 'returns the given identifier' do
        config = Liftoff::ProjectConfiguration.new({})
        config.company_identifier = 'foo'

        expect(config.company_identifier).to eq 'foo'
      end
    end

    context 'when the identifier is not set directly' do
      it 'returns a reverse domain string from the normalized company name' do
        config = Liftoff::ProjectConfiguration.new({})
        config.company = 'My Cool Company!'

        expect(config.company_identifier).to eq 'com.mycoolcompany'
      end
    end
  end

  describe '#author' do
    context 'when the author name is set directly' do
      it 'returns the given author name' do
        config = Liftoff::ProjectConfiguration.new({})
        config.author = 'Bunk Moreland'

        expect(config.author).to eq 'Bunk Moreland'
      end
    end

    context 'when the author name is not set directly' do
      it 'returns the name of the current user from passwd(5)' do
        config = Liftoff::ProjectConfiguration.new({})
        getpwuid = double('getpwuid', gecos: 'Jimmy McNulty')
        Etc.stub(:getpwuid) { getpwuid }

        expect(config.author).to eq 'Jimmy McNulty'
      end
    end
  end
end
