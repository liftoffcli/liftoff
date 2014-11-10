module Liftoff
  class Project
    def initialize(configuration)
      @name = configuration.project_name
      @deployment_target = configuration.deployment_target
      @test_target_name = configuration.test_target_name
      set_company_name(configuration.company)
      set_prefix(configuration.prefix)
      configure_base_project_settings
    end

    def app_target
      @app_target ||= new_app_target
    end

    def unit_test_target
      @unit_test_target ||= new_test_target(@test_target_name)
    end

    def save
      reorder_groups
      xcode_project.save
    end

    def new_group(name, path)
      xcode_project.new_group(name, path)
    end

    def generate_scheme
      scheme = Xcodeproj::XCScheme.new
      scheme.add_build_target(app_target)
      scheme.add_test_target(unit_test_target)
      scheme.set_launch_target(app_target)
      scheme.save_as(xcode_project.path, @name)
    end

    private

    def reorder_groups
      children = xcode_project.main_group.children
      frameworks = xcode_project.frameworks_group
      products = xcode_project.products_group
      children.move(frameworks, -1)
      children.move(products, -1)
    end

    def new_app_target
      target = xcode_project.new_target(:application, @name, :ios)
      target.build_configurations.each do |configuration|
        configuration.build_settings.delete('OTHER_LDFLAGS')
        configuration.build_settings.delete('IPHONEOS_DEPLOYMENT_TARGET')
        configuration.build_settings.delete('SKIP_INSTALL')
        configuration.build_settings['LD_RUNPATH_SEARCH_PATHS'] = ['$(inherited)', '@executable_path/Frameworks']
      end
      target
    end

    def set_prefix(prefix)
      xcode_project.root_object.attributes['CLASSPREFIX'] = prefix
    end

    def set_company_name(company)
      xcode_project.root_object.attributes['ORGANIZATIONNAME'] = company
    end

    def new_test_target(name)
      target = xcode_project.new_resources_bundle(name, :ios)
      target.product_type = 'com.apple.product-type.bundle.unit-test'
      target.product_reference.name = "#{name}.xctest"
      target.add_dependency(app_target)
      configure_search_paths(target)
      target.build_configurations.each do |configuration|
        configuration.build_settings['BUNDLE_LOADER'] = "$(BUILT_PRODUCTS_DIR)/#{@name}.app/#{@name}"
        configuration.build_settings['WRAPPER_EXTENSION'] = 'xctest'
        configuration.build_settings['TEST_HOST'] = '$(BUNDLE_LOADER)'
      end
      target
    end

    def configure_base_project_settings
      xcode_project.build_configurations.each do |configuration|
        configuration.build_settings['CODE_SIGN_IDENTITY[sdk=iphoneos*]'] = 'iPhone Developer'
        configuration.build_settings['ASSETCATALOG_COMPILER_APPICON_NAME'] = 'AppIcon'
        configuration.build_settings['SDKROOT'] = 'iphoneos'
        configuration.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = @deployment_target.to_s
      end
    end

    def configure_search_paths(target)
      target.build_configurations.each do |configuration|
        configuration.build_settings['FRAMEWORK_SEARCH_PATHS'] = ['$(SDKROOT)/Developer/Library/Frameworks', '$(inherited)', '$(DEVELOPER_FRAMEWORKS_DIR)']
      end
    end

    def xcode_project
      path = Pathname.new("#{@name}.xcodeproj").expand_path
      @project ||= Xcodeproj::Project.new(path)
    end
  end
end
