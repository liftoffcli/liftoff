module Liftoff
  class ProjectBuilder

    def initialize(project_configuration)
      @project_configuration = project_configuration
    end

    def create_project
      groups_and_targets.each do |groups, target|
        groups.each do |group|
          create_tree(group, target)
        end
      end

      xcode_project.save
      xcode_project.generate_scheme
    end

    private

    def create_tree(current_element, target, path = [], parent_group = xcode_project)
      if template_file?(current_element)
        add_file(current_element, target, path, parent_group)
      else
        create_groups_for_tree(current_element, target, path, parent_group)
      end
    end

    def add_file(file, target, path, parent_group)
      file_manager.mkdir_gitkeep(path)
      move_template(path, file)
      link_file(file, parent_group, path, target)
    end

    def create_groups_for_tree(tree, target, path, parent_group)
      tree.each_pair do |raw_directory, children|
        name = string_renderer.render(raw_directory)
        path += [name]
        created_group = create_group(name, path, parent_group)

        if children
          children.each do |child|
            create_tree(child, target, path, created_group)
          end
        end
      end
    end

    def create_group(name, path, parent_group)
      file_manager.mkdir_gitkeep(path)
      parent_group.new_group(name, name)
    end

    def move_template(path, raw_template_name)
      rendered_template_name = string_renderer.render(raw_template_name)
      destination_template_path = File.join(*path, rendered_template_name)
      FileManager.new.generate(raw_template_name, destination_template_path, @project_configuration)
    end

    def link_file(raw_template_name, parent_group, path, target)
      rendered_template_name = string_renderer.render(raw_template_name)
      file = parent_group.new_file(rendered_template_name)

      if resource_file?(rendered_template_name)
        target.add_resources([file])
      elsif linkable_file?(rendered_template_name)
        target.add_file_references([file])
      else
        add_file_to_build_settings(rendered_template_name, path, target)
      end
    end

    def add_file_to_build_settings(name, path, target)
      file_path = File.join(*path, name)

      target.build_configurations.each do |configuration|
        if name.end_with?('plist')
          configuration.build_settings['INFOPLIST_FILE'] = file_path
        elsif name.end_with?('pch')
          configuration.build_settings['GCC_PREFIX_HEADER'] = file_path
        end
      end
    end

    def linkable_file?(name)
      !name.end_with?('h', 'Info.plist')
    end

    def resource_file?(name)
      name.end_with?('xcassets')
    end

    def template_file?(object)
      object.class == String
    end

    def groups_and_targets
      group_map = {
        @project_configuration.application_target_groups => xcode_project.app_target,
      }

      if @project_configuration.unit_test_target_groups
        group_map[@project_configuration.unit_test_target_groups] = xcode_project.unit_test_target
      end

      group_map
    end

    def xcode_project
      @xcode_project ||= Project.new(@project_configuration)
    end

    def file_manager
      @file_manager ||= FileManager.new
    end

    def string_renderer
      @renderer ||= StringRenderer.new(@project_configuration)
    end
  end
end
