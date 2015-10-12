# liftoffrc

**liftoffrc** - configuration for **liftoff**

## Description

The **liftoff** Xcode configuration tool can be configured using a *.liftoffrc* file in your home directory, or the directory from which you are running **liftoff**. This is a YAML file that defines a set of keys and values for configuring **liftoff**.

**liftoff** will use the value for a given key from *./.liftoffrc*, then *~/.liftoffrc*.  If it can't find a value in those files, it will use the default configuration.

## Usage

You can use the lookup order to improve the experience when creating new projects. For example, you can set the author key inside *~/.liftoffrc*:

`author: Gordon Fontenot`

Now, any projects you create will have your name set as the author by default.

You can also use local **liftoffrc** files to customize information at a higher level. For example, you can set the company key inside *~/dev/work-projects/.liftoffrc*:

`company: thoughtbot`

Now, whenever you create projects for work, the company name will default to thoughtbot, and the author name will default to Gordon Fontenot.

You can continue to create these for any directory in order to tweak the settings for projects created inside them. For example, I also have company set inside *~/dev/personal/.liftoffrc*:

`company: Gordon Fontenot`

I could also set the warnings key to enable different warnings based on client requirements, or personal preference.

## Configuration

+ `project_template`
  * type: **string**
  * default: **swift**

  Set the default template to use for project generation. This key corresponds to a top level key under `app_target_templates`. If the key also exists in `test_target templates`, then that template will be used for the test target.

  This setting can be overridden on the command line by using the `--template TEMPLATE_NAME` option.

+ `deployment_target`
  * type: **float**
  * default: **8.0**

  Set the desired deployment target for this project.

+ `configure_git`
  * type: **boolean**
  * default: **true**

  Create *.gitignore*, *.gitattributes*, and initialize git repo if needed.

+ `warnings_as_errors`
  * type: **boolean**
  * default: **true**

  Turn warnings into errors on release builds.

+ `run_script_phases`
  * type: **array**
  * default: See **SCRIPT PHASES**

  Install the specified scripts as individual Run Script Build Phases. The scripts that you want to add should be located inside either the local *.liftoff/templates/* directory, or the user's *~/.liftoff/templates/* directory.

  Each item in the array should be a dictionary containing a single key/value pair. The key for the dictionary will be used as the template script's name. The value will be used as the name of the script phase inside Xcode.

+ `enable_static_analyzer`
  * type: **boolean**
  * default: **true**

  Turn on the static analyzer for the project.

+ `indentation_level`
  * type: **integer**
  * default: **4**

  Set the indentation width on the project (in spaces).

+ `use_tabs`
  * type: **boolean**
  * default: **false**

  Configure the project to use spaces or tabs for indentation. As everyone knows, you should really be using spaces for indentation. If you prefer to be wrong, however, you can change this configuration to use tabs in your project.

  Note that this does **not** affect the default templates. If you choose to be incorrect with your indentation settings, we recommend that you also override the default templates in order to be consistently wrong.

+ `use_cocoapods`
  * type: **boolean**
  * default: **true**

  Generate a template *Podfile* and run `pod install` inside the project directory to install a default set of dependencies.

  The *Podfile* can be overridden by adding a custom template. If you override this template, you should probably override the *UnitTests-Prefix.pch* template as well, since it imports the default pods if this key is enabled.

+ `strict_prompts`
  * type: **boolean**
  * default: **false**

  Only prompt for values that don't have a default value.

  This is useful when combined with command line options to speed up the project creation process, or when being used in environments where the interactive prompt can't be used.

+ `warnings`
  * type: **array**
  * default: See **WARNINGS**

  Enable the provided warnings for the Application target. Set to false to prevent warnings from being set.

+ `templates`
  * type: **array**
  * default: See **TEMPLATES**

  Generate the specified templates for the project. User-defined templates should be located either inside the local *.liftoff/templates/* directory, or in the user's *~/.liftoff/templates/* directory.

  Each item in the array should be a single key/value pair. The key for the dictionary will be used as the template's name, and the value will be used as the destination relative to the project's root.

  See **TEMPLATES** for an example configuration.

+ `app_target_templates`
  * type: **dictionary**
  * default: See **TEMPLATE DIRECTORY STRUCTURES**

  Specify template directory structures for the main application target. By default, this comes with 2 templates: swift and objc.

+ `test_target_groups`
  * type: **dictionary**
  * default: See **TEMPLATE DIRECTORY STRUCTURES**

  Specify template directory structures for the unit test target. By default, this comes with 2 templates: swift and objc.

+ `test_target_name`
  * type: **string**
  * default: **UnitTests**

  Set the name of the unit test target.

+ `project_name`
  * type: **string**
  * default: **none**

  Set the default value for the project name when generating new projects. Not defined by default.

+ `company`
  * type: **string**
  * default: **none**

  Set the default value for the company name when generating new projects. Not defined by default.

+ `company_identifier`
  * type: **string**
  * default: **based on company name**

  Set the default value for the company identifier when generating new projects. Default value is the provided company name, downcased and stripped of special characters. For example: `My Company Name!` becomes `com.mycompanyname`.

+ `author`
  * type: **string**
  * default: Pulled from the **gecos** field in [passwd](http://man7.org/linux/man-pages/man1/passwd.1.html)

  Set the default value for the author name when generating new projects. The current user's name will be automatically set as the default.

+ `prefix`
  * type: **string**
  * default: **none**

  Set the default value for the project prefix when generating new projects. Not enabled by default.

+ `xcode_command`
  * type: **string**
  * default: `open -a 'Xcode'`.

  Set the command used to open the project after generation. By default we open the current folder with Xcode, which will search for a *.xcworkspace* file to open, falling back to a *.pbxproj* file if it can't find one.

  Set this key to false to disable the automatic-open functionality

+ `build_configurations`
  * type: **dictionary**
  * default: **none**

  Add additional build configurations to the project. By default this key isn't set. See **BUILD CONFIGURATIONS** for more information on the format of this key.

+ `extra_config`
  * type: **dictionary**
  * default: **none**

  Add additional per-configuration settings to the main application target. By default this key isn't set. See **EXTRA CONFIGURATION** for more information on the format of this key.

+ `extra_test_config`
  * type: **dictionary**
  * default: **none**

  Add additional per-configuration settings to the test target. By default this key isn't set. See **EXTRA CONFIGURATION** for more information on the format of this key.

+ `enable_settings`
  * type: **boolean**
  * default: **true**

  Create a settings bundle. If you also have `use_cocoapods` enabled, this settings bundle will automatically contain the acknowledgements for any installed pods.

+ `schemes`
  * type: **dictionary**
  * default: **none**

  Create additional custom schemes. By default this key isn't set. See **CUSTOM SCHEMES** for more information on the format of this key.

## Script phases

**liftoff** installs two Run Script Build Phases by default:

+ file: *todo.sh*

  name: Warn for TODO and FIXME comments

  This script turns any TODO or FIXME comments into warnings at compilation time.

+ file: *bundle_version.sh*

  name: Set the version number

  This script sets the build number based on the number of git commits on master, and sets the marketing version based on the most recent git tag.

  You can also add an optional index key to the build phase. The value of this key (an integer) will be used to determine where to insert the build phase when adding it to the target. This list is zero-indexed. You can use -1 to indicate that the script should be added to the end, which is the default behavior.

+ file: *my_custon_script.sh*

  name: Run my custom script before anything else

  index: 0

## Warnings

**liftoff** enables a set of warnings by default:

+ `GCC_WARN_INITIALIZER_NOT_FULLY_BRACKETED`

  Warn if an aggregate or union initializer is not fully bracketed.

+ `GCC_WARN_MISSING_PARENTHESES`

  Warn if parentheses are omitted in certain contexts, such as when there is an assignment in a context where a truth value is expected, or when operators are nested whose precedence people often get confused about.

+ `GCC_WARN_ABOUT_RETURN_TYPE`

  Causes warnings to be emitted when a function with a defined return type (not void) contains a return statement without a return-value.  Also emits a warning when a function is defined without specifying a return type.

+ `GCC_WARN_SIGN_COMPARE`

  Warn when a comparison between signed and unsigned values could produce an incorrect result when the signed value is converted to unsigned.

+ `GCC_WARN_CHECK_SWITCH_STATEMENTS`

  Warn whenever a switch statement has an index of enumeral type and lacks a case for one or more of the named codes of that enumeration.

+ `GCC_WARN_UNUSED_FUNCTION`

  Warn whenever a static function is declared but not defined or a non-inline static function is unused.

+ `GCC_WARN_UNUSED_LABEL`

  Warn whenever a label is declared but not used.

+ `GCC_WARN_UNUSED_VALUE`

  Warn whenever a statement computes a result that is explicitly not used.

+ `GCC_WARN_UNUSED_VARIABLE`

  Warn whenever a local variable or non-constant static variable is unused aside from its declaration.

+ `GCC_WARN_SHADOW`

  Warn whenever a local variable shadows another local variable, parameter or global variable or whenever a built-in function is shadowed.

+ `GCC_WARN_64_TO_32_BIT_CONVERSION`

  Warn if a value is implicitly converted from a 64 bit type to a 32 bit type.

+ `GCC_WARN_ABOUT_MISSING_FIELD_INITIALIZERS`

  Warn if a structure's initializer has some fields missing.

+ `GCC_WARN_ABOUT_MISSING_NEWLINE`

  Warn when a source file does not end with a newline.

+ `GCC_WARN_UNDECLARED_SELECTOR`

  Warn if a `@selector(...)` expression referring to an undeclared selector is found.

+ `GCC_WARN_TYPECHECK_CALLS_TO_PRINTF`

  Check calls to `printf` and `scanf`, etc., to make sure that the arguments supplied have types appropriate to the format string specified, and that the conversions specified in the format string make sense.

+ `GCC_WARN_ABOUT_DEPRECATED_FUNCTIONS`

  Warn about the use of deprecated functions, variables, and types (as indicated by the deprecated attribute).

+ `CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATION`

  Warn if an Objective-C class either subclasses a deprecated class or overrides a method that has been marked deprecated.

+ `CLANG_WARN_OBJC_IMPLICIT_RETAIN_SEL`

  Warn about implicit retains of `self` within blocks, which can create a retain-cycle.

+ `CLANG_WARN_IMPLICIT_SIGN_CONVERSION`

  Warn about implicit integer conversions that change the signedness of an integer value.

+ `CLANG_WARN_SUSPICIOUS_IMPLICIT_CONVERSION`

  Warn about various implicit conversions that can lose information or are otherwise suspicious.

+ `CLANG_WARN_EMPTY_BODY`

  Warn about loop bodies that are suspiciously empty.

+ `CLANG_WARN_ENUM_CONVERSION`

  Warn about implicit conversions between different kinds of enum values.  For example, this can catch issues when using the wrong enum flag as an argument to a function or method.

+ `CLANG_WARN_INT_CONVERSION`

  Warn about implicit conversions between pointers and integers. For example, this can catch issues when one incorrectly intermixes using `NSNumber*` and raw integers.

+ `CLANG_WARN_CONSTANT_CONVERSION`

  Warn about implicit conversions of constant values that cause the constant value to change, either through a loss of precision, or entirely in its meaning.

## Templates

**liftoff** installs a number of templates by default:

+ *travis.yml*

  This template is installed to *.travis.yml*, and contains a default setup for Travis integration.

+ *Gemfile.rb*

  This template is installed to *Gemfile*, and contains a set of default gems for use with the project. Right now, it contains CocoaPods and XCPretty.

+ *test.sh*

  This template is installed to bin/test and enables the running of tests from the command line. This is used by the default *travis.yml* template to determine build status.

**liftoff** expects templates in the following format:

+ *travis.yml*: *.travis.yml*

This will install the template named *travis.yml* found inside the templates directory to *.travis.yml* inside the project directory.

This file will be parsed with ERB with the project configuration, giving you access to any values that you can set via the **liftoffrc**

## Template directory structures

**liftoff** creates default directory and group structures for application and unit test targets. These structures are specified with language specific keys inside the *app_target_templates* and *test_target_templates* configuration keys. **liftoff** will select the proper structure to build based on the *project_template* setting either in the **liftoffrc** or as provided on the command line with the `--template [TEMPLATE_NAME]` option.

An example project template for Objective-C projects might look like the following:

* app_target_templates:
  * objc:
    * <%= project_name %>:
      * Categories:
      * Classes:
        * Controllers:
        * DataSources:
        * Delegates:
          * <%= prefix %>AppDelegate.h
          * <%= prefix %>AppDelegate.m
        * Models:
        * ViewControllers:
        * Views:
      * Constants:
      * Resources:
        * Images.xcassets
        * Storyboards:
        * Nibs:
        * Other-Sources:
          * <%= project_name %>-Info.plist
          * <%= project_name %>-Prefix.pch
          * main.m

This would override the default objc template for the main application target. This structure would also cause liftoff to generate templates for the
`AppDelegate` class (prepending the proper prefix), as well as *Info.plist*, *Prefix.pch*, and *main.m* files. The *Info.plist* and *Prefix.pch* will be prepended with the project name.

See **Templates** for more information on **liftoff**'s templating ability.

These keys are special, in that you can add template specific keys inside your user or local **liftoffrc** files without overriding the defaults. This means that if I want to define a new *empty* template, I can do so with the following inside my local or user **liftoffrc**:

* app_target_templates:
  * empty:
    * Files:

This would create a single *Files* directory inside the project root, and would not create a test target, since I haven't defined a template directory structure for that target. You can now specify this template by name by using `--template` empty on the command line, or even make it your default by setting `project_template` in your **liftoffrc**.

## Build configurations

**liftoff** can add additional build configurations to the project. In order to do it, you should add the `build_configurations` key in your **liftoffrc**, and add dictionaries that correspond to the build configurations you'd like to add.

A new build configuration can either be of *debug* type or *release*.

For example, you can create build configurations that will be used when uploading to the App Store:

* build_configurations:
  * name: Debug-AppStore

    type: debug

  * name: Release-AppStore

    type: release

Note that the value of *type* key must be either *debug* or *release*.

You can use the created build configurations to create a scheme with the *schemes* key. You can also customize the created configurations with the `extra_config` key.

## Extra configuration

**liftoff** can perform additional arbitrary configuration to the main application target or the test target on a per-build configuration basis. In order to add arbitrary settings, you should add the `extra_config` or `the extra_test_config` key in your **liftoffrc**, and add dictionaries that correspond to the build configuration you'd like to modify. For example, to set all warnings on your *Debug* build configuration, you can set the following:

* extra_config:
  * Debug:
    * WARNING_CFLAGS:
      * -Weverything

Note that the key for the build configuration must match the name of the build configuration you'd like to modify exactly.

If you would like to add a setting for all available build configurations, you can use the special *all* key in the configuration:

* extra_config:
  * all:
    * WARNING_CFLAGS:
      * -Weverything

## Custom schemes

**liftoff** can create additional custom schemes for your application. To do so, you need to specify a name and which build configuration will be used for each *action* (test, launch, profile, archive or analyze). In order to create additional schemes, you should add the *schemes* key in your **liftoffrc**, and add dictionaries that correspond to the schemes you'd like to create.  For example, to create a scheme that will be used when distributing your app to the App Store, you can set the following:

* schemes:
* name: <%= project_name %>-AppStore
*   actions:
      * test:
        * build_configuration: Debug
      * launch:
        * build_configuration: Debug
      * profile:
        * build_configuration: Release
      * archive:
        * build_configuration: Release
      * analyze:
        * build_configuration: Debug

Note that the keys inside actions must match the predefined keys and the key for the build configuration must match the name of the build configuration you'd like to use exactly.
