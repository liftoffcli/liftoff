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

  describe '#each_template' do
    it 'returns an array of templates and destinations' do
      templates = [
        {'foo' => 'bar'},
        {'baz' => 'bat'}
      ]

      config = Liftoff::ProjectConfiguration.new({:templates => templates})

      expect(config.each_template.to_a).to eq([['foo', 'bar'], ['baz', 'bat']])
    end
  end

  describe '#app_target_groups' do
    context 'when the project_template is set to swift' do
      it 'returns the swift app target groups' do
        swift_groups = {'swift' => 'groups'}
        objc_groups = {'objc' => 'groups'}
        templates = {'swift' => swift_groups, 'objc' => objc_groups}
        config = Liftoff::ProjectConfiguration.new({
          :project_template => 'swift',
          :app_target_templates => templates
        })

        expect(config.app_target_groups).to eq(swift_groups)
      end
    end

    context 'when the project_template is set to objc' do
      it 'returns the objc app target groups' do
        swift_groups = {'swift' => 'groups'}
        objc_groups = {'objc' => 'groups'}
        templates = {'swift' => swift_groups, 'objc' => objc_groups}
        config = Liftoff::ProjectConfiguration.new({
          :project_template => 'objc',
          :app_target_templates => templates
        })

        expect(config.app_target_groups).to eq(objc_groups)
      end
    end
  end

  describe '#test_target_groups' do
    context 'when the project_template is set to swift' do
      it 'returns the swift test target groups' do
        swift_groups = {'swift' => 'groups'}
        objc_groups = {'objc' => 'groups'}
        templates = {'swift' => swift_groups, 'objc' => objc_groups}
        config = Liftoff::ProjectConfiguration.new({
          :project_template => 'swift',
          :test_target_templates => templates
        })

        expect(config.test_target_groups).to eq(swift_groups)
      end
    end

    context 'when the project_template is set to objc' do
      it 'returns the objc test target groups' do
        swift_groups = {'swift' => 'groups'}
        objc_groups = {'objc' => 'groups'}
        templates = {'swift' => swift_groups, 'objc' => objc_groups}
        config = Liftoff::ProjectConfiguration.new({
          :project_template => 'objc',
          :test_target_templates => templates
        })

        expect(config.test_target_groups).to eq(objc_groups)
      end
    end
  end
end
