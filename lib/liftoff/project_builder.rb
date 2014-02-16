require 'pry'
require 'fileutils'
require 'xcodeproj'
require 'erb'

module Liftoff
  class ProjectBuilder

    def initialize(project_config)
      @project_config = project_config
    end

    def create_project
      xcode_project.root_object.attributes['CLASSPREFIX'] = @project_config.prefix
      xcode_project.root_object.attributes['ORGANIZATIONNAME'] = @project_config.company
      xcode_project.build_configurations.each do |configuration|
        configuration.build_settings['ARCHS'] = '$(ARCHS_STANDARD_INCLUDING_64_BIT)'
      end

      application_target_groups = [{ @project_config.name => @project_config.application_target_groups }]
      unit_test_target_groups = [{ 'UnitTests' => @project_config.unit_test_target_groups }]

      application_target_groups.each do |directory|
        create_tree(directory, app_target)
      end

      unit_test_target_groups.each do |directory|
        create_tree(directory, unit_test_target)
      end

      xcode_project.save
    end

    private

    def app_target
      @app_target ||= xcode_project.new_target(:application, @project_config.name, :ios, 7.0)
    end

    def unit_test_target
      @unit_test_target ||= new_test_target('UnitTests')
    end

    def new_test_target(name)
      target = xcode_project.new_resources_bundle(name, :ios)
      target.add_dependency(app_target)
      configure_search_paths(target)
      target.frameworks_build_phases.add_file_reference(xctest_framework_file_reference)
      target.build_configurations.each do |configuration|
        configuration.build_settings['BUNDLE_LOADER'] = "$(BUILT_PRODUCTS_DIR)/#{@project_config.name}.app/#{@project_config.name}"
        configuration.build_settings['WRAPPER_EXTENSION'] = 'xctest'
        configuration.build_settings['TEST_HOST'] = '$(BUNDLE_LOADER)'
      end
      target
    end

    def xctest_framework_file_reference
      xctest = xcode_project.frameworks_group.new_file('XCTest.framework')
      xctest.set_source_tree(:developer_dir)
      xctest.set_path('Library/Frameworks/XCTest.framework')
      xctest.name = 'XCTest.framework'
      xctest
    end

    def configure_search_paths(target)
      target.build_configurations.each do |configuration|
        configuration.build_settings['FRAMEWORK_SEARCH_PATHS'] = ['$(SDKROOT)/Developer/Library/Frameworks', '$(inherited)', '$(DEVELOPER_FRAMEWORKS_DIR)']
      end
    end

    def create_tree(tree, target, path = [], parent_group = xcode_project)
      if tree.class == String
        mkdir_gitkeep(path)
        move_template(path, tree)
        link_file(tree, parent_group, path, target)
        return
      end

      tree.each_pair do |raw_directory, child|
        directory = rendered_string(raw_directory)
        path += [directory]
        mkdir_gitkeep(path)
        created_group = create_group(directory, parent_group)
        if child
          child.each do |c|
            create_tree(c, target, path, created_group)
          end
        end
      end
    end

    def mkdir_gitkeep(path)
      dir_path = File.join(*path)
      FileUtils.mkdir_p(dir_path)
      FileUtils.touch(File.join(dir_path, '.gitkeep'))
    end

    def create_group(name, parent_group)
      parent_group.new_group(name, name)
    end

    def move_template(path, raw_template_name)
      rendered_template_name = rendered_string(raw_template_name)
      destination_template_path = File.join(*path, rendered_template_name)
      FileManager.new.generate(raw_template_name, destination_template_path, @project_config)
    end

    def link_file(raw_template_name, parent_group, path, target)
      rendered_template_name = rendered_string(raw_template_name)
      file = parent_group.new_file(rendered_template_name)
      unless rendered_template_name.end_with?('h', 'plist')
        target.add_file_references([file])
      end

      if rendered_template_name.end_with?('plist')
        target.build_configurations.each do |configuration|
          configuration.build_settings['INFOPLIST_FILE'] = File.join(*path, rendered_template_name)
        end
      elsif rendered_template_name.end_with?('pch')
        target.build_configurations.each do |configuration|
          configuration.build_settings['GCC_PREFIX_HEADER'] = File.join(*path, rendered_template_name)
        end
      end
    end

    def xcode_project
      path = Pathname.new("#{@project_config.name}.xcodeproj").expand_path
      @project ||= Xcodeproj::Project.new(path)
    end

    def rendered_string(raw_string)
      ERB.new(raw_string).result(@project_config.get_binding)
    end
  end
end
