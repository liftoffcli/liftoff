# liftoff

**liftoff** - create and configure Xcode projects

## Description

**liftoff** is designed to help iOS developers quickly get projects up and running without spending valuable time performing tedious configurations.

Run the **liftoff** command inside a directory.

#### It supports the following options:

+ `-v, --version` - display the version number and exit
+ `-h, --help` - display a help message and exit
+ `--[no]strict-prompts` - enable or disable strict prompts. If this is enabled, **liftoff** will only prompt for values that don't have a default set
+ `--[no-]cocoapods` - enable or disable [CocoaPods](https://cocoapods.org) support
+ `--[no-]git` - enable or disable git configuration
+ `--no-open` - don't open Xcode after project generation
+ `--[no-]settings` - enable or disable Settings.bundle
+ `--template TEMPLATE_NAME` - use the specified template structure
+ `-t, --indentation N` - set the indentation width in spaces
+ `-n, --name PROJECT_NAME` - set the project name
+ `-c, --company COMPANY_NAME` - set the company name
+ `-a, --author AUTHOR_NAME` - set the author name. If you don't provide a default here or in the *liftoffrc*, **liftoff** will generate a default value by looking at the **gecos** from [passwd](http://man7.org/linux/man-pages/man1/passwd.1.html)
+ `-p, --prefix PREFIX` - set the project's prefix
+ `-i, --identifier IDENTIFIER` - set the company identifier (com.mycompany). If you don't provide a default here or in the *liftoffrc*, **liftoff** will generate a default from a normalized version of the company name
+ `--test-target-name TEST_TARGET_NAME` - set the name for the test target

If an Xcode project is found inside the current directory, **liftoff** will configure the exisiting project.

If no existing project is found, **liftoff** will generate a new project structure, create a new Xcode project, and perform the same configurations.

If you pass a custom pass on the command line, **liftoff** will use that path as the root folder for the project generation. Otherwise, it will use the project's name by default.

#### The following configuration will be performed:

+ Set the indentation level on the project (in spaces, 4 by default)
+ Enable additional warnings at the project level
+ Treat warnings as errors for release schemes
+ Add a build phase shell script to turn **TODO** and **FIXME** comments into warnings
+ Add a build phase shell script to automatically set the app's version information based on github
+ Turn on static analysis for the project
+ Perform arbitrary configuration as specified by the user's *liftoffrc*
+ Add default *.gitignore* and *.gitattributes* files
+ Initialize a new git repository and create an initial commit (if needed)

## Configuration

You can use *.liftoffrc* file to speed up and customize your configuration by pre-defining your preferred configurations. This is a YAML file that defines a set of keys and values for configuring **liftoff**.

See *liftoffrc.md* for more detailed information on configuration.

## Templates

You can add custom templates or override the default templates by adding them to *~/.liftoff/templates/* or *./.liftoff/templates/*.

**liftoff** will use same fallback order for the templates that it does for the *.liftoffrc*:
1. Local directory: *./.liftoff/templates/*
2. User directory: *~/.liftoff/templates/*
3. Default templates: *<liftoff-installation-location>/templates/*

These templates and their filenames will be rendered with **ERB**. You can use any value available in the *liftoffrc* configuration inside the template.
