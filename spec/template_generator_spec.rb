require 'spec_helper'

describe Liftoff::TemplateGenerator do
  describe '#generate_templates' do
    context 'when there are no templates provided' do
      it 'does nothing' do
        manager = stubbed_file_manager

        generator = Liftoff::TemplateGenerator.new
        generator.generate_templates(configuration_with_templates(nil), manager)

        expect(manager).to_not have_received(:generate)
      end
    end

    context 'when it is given templates' do
      it 'tells the FileManager to generate the templates' do
        manager = stubbed_file_manager
        templates = {
          'foo' => 'bar',
          'baz' => 'quz'
        }
        configuration = configuration_with_templates(templates)

        generator = Liftoff::TemplateGenerator.new
        generator.generate_templates(configuration, manager)

        expect(manager).to have_received(:generate).twice
        templates.each do |template, destination|
          expect(manager).to have_received(:generate).with(template, destination, configuration)
        end
      end
    end
  end
end

def configuration_with_templates(templates)
  double('ProjectConfiguration', :templates => templates)
end

def stubbed_file_manager
  double('FileManager', :generate => nil)
end
