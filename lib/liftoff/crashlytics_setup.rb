module Liftoff
  class CrashlyticsSetup
    
    # constants
    CRASHLYTICS_BUNDLE_ID = 'com.crashlytics.mac'
    CRASHLYTICS_ENDPOINT_URL = 'https://fabric.io/api/v2/session.json'
    CRASHLYTICS_TOKEN_HEADER_KEY = 'X-CRASHLYTICS-DEVELOPER-TOKEN'
    
    # methods
    
    def install_crashlytics(config, use_crashlytics)
      @config = config
      
      if use_crashlytics
        if pod_installed?
          append_podfile
          run_pod_install
          
          puts "Crashlytics setup..."
          
          @crashlytics_key = init_crashlytics        
          get_credentials
          organizations = get_organizations
          
          organization = pick_organization(organizations)
          integrate organization 
          puts "Crashlytics integration success!"
        else
          puts 'Please install CocoaPods or disable pods from liftoff'
        end
      else
        update_template false
      end
      
    rescue => e
      puts "Crashlytics setup failed! Message: #{e}"
    end

    private
    
    def integrate organization
      update_template true, organization
      
      xcode_helper.add_script_phase("Crashlytics", "./Pods/CrashlyticsFramework/Crashlytics.framework/run #{organization.values[0]}  #{@crashlytics_key}")
    end
    
    def pick_organization organizations
      organization = nil

      choose do |menu|
        menu.prompt = "Please choose your Crashlytics organization:  "
        
        organizations.keys.each do |key|
          menu.choice(key) {organization = {key => organizations[key]}}
        end
      end
      
      organization
    end
    
    def get_credentials
      @email = ask("Enter your crashlytics email: ")
      @password = ask("Enter your password: ") { |q| q.echo = false }
    end
    
    def init_crashlytics
      app_path = `mdfind "kMDItemCFBundleIdentifier == '#{CRASHLYTICS_BUNDLE_ID}'" 2>/dev/null`.split($/).first
      raise_error("Crashlytics does <%= color('not', BOLD) %> seem to be installed!") if app_path.nil? || app_path.empty?
      
      if app_path.match(/Crashlytics.app/) 
        app_path = File.join(app_path, 'Contents', 'MacOS', 'Crashlytics')
      else
        app_path = File.join(app_path, 'Contents', 'MacOS', 'Fabric')
      end
      raise_error("The Crashlytics binary (#{app_path}) is <%= color('not', BOLD) %> readable.") unless File.file? app_path
  
      strings = `strings -n #{CRASHLYTICS_TOKEN_HEADER_KEY.length} '#{app_path}' | grep -C10 '#{CRASHLYTICS_TOKEN_HEADER_KEY}' 2>/dev/null`.split($/)
      strings.select! { |s| s =~ /^[0-9a-f]{40}$/i }  # We're looking for a 40-character hex string
      
      # If we didn't match anything, or we matched too many things, bail. Better safe than sorry.
      raise_error("Unable to find your developer token in the Crashlytics binary.") unless strings.length == 1
        
      strings[0]
    end
    
    def get_organizations
      get_organizations_from_api @crashlytics_key, @email, @password
    end
    
    def get_organizations_from_api(dev_token, email, password)
      response = HTTParty.post("#{CRASHLYTICS_ENDPOINT_URL}",
                               body: {'email' => email, 'password' => password }.to_json,
                               headers: {  'Content-Type' => 'application/json', 'X-CRASHLYTICS-DEVELOPER-TOKEN' =>  dev_token},
                               limit: 10)
                               
      body = JSON.parse(response.body)
      organizations = body['organizations']
      
      raise_error 'No organizations found!' if !organizations || organizations.empty?
      
      Hash[organizations.map { |o| [o['name'], o['api_key']] }]
    end
    
    def update_template use_crashlytics, organization = nil
      file_list = file_list = Dir.glob("**/*AppDelegate.*")
      if use_crashlytics
        if file_list.first[/\.h|\.m/]
          file_manager.replace_in_files(file_list, "(((CRASHLYTICS_HEADER)))", "#include <Crashlytics/Crashlytics.h>")
          file_manager.replace_in_files(file_list, "(((CRASHLYTICS_APIKEY)))", "[Crashlytics startWithAPIKey:@\"#{organization.values[0]}\"];")
        elsif file_list.first[/\.swift/]
          file_manager.replace_in_files(file_list, "(((CRASHLYTICS_HEADER)))", "@import 'Crashlytics'")
          file_manager.replace_in_files(file_list, "(((CRASHLYTICS_APIKEY)))", "Crashlytics.startWithAPIKey(@\"#{organization.values[0]}\")")
        end
        
      else
        file_manager.replace_in_files(file_list, "(((CRASHLYTICS_HEADER)))", "")
        file_manager.replace_in_files(file_list, "(((CRASHLYTICS_APIKEY)))", "")
      end
    end
    
    def pod_installed?
      system('which pod')
    end

    def append_podfile
      File.open('Podfile', 'a') do |file|
        file.write("\n# Add support for crashlytics\n")
        file.write("pod 'CrashlyticsFramework'\n")
      end  
    end

    def run_pod_install
      puts 'Running pod install'
      system('pod install')
    end
    
    def xcode_helper
      @xcode_helper ||= XcodeprojHelper.new
    end
    
    def file_manager
      @file_manager ||= FileManager.new
    end
    
    def raise_error text
      say(text)
      
      raise
    end
    
  end
end
