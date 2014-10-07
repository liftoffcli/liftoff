# Liftoff Changelog #

## Liftoff 1.4.1 - 7 Oct 2014 ##

### Bug Fixes ###

* Now using an updated version of [Xcodeproj][] to fix some segfaults reported
  by CocoaPods users.

[Xcodeproj]: https://github.com/CocoaPods/Xcodeproj

## Liftoff 1.4 - 6 Oct 2014 ##

### New Features ###

* Add the ability to define multiple project templates. This feature allows
  you to created named project templates inside your liftoffrc and then use
  them by defining them as the default inside your liftoffrc, or by passing
  their name on the command line. Be sure to check out `liftoff(1)` and
  `liftoffrc(5)` for  more info. By default, Liftoff comes with templates for
  Objective-C (`objc`) and Swift (`swift`) projects. - [Gordon
  Fontenot][liftoff#175]
* Add arbitrary configuration settings to liftoffrc. This lets you define an
  arbitrary dictionary structure inside your liftoffrc to create default
  configuration settings for projects. - [Gordon Fontenot][liftoff#174]
  ([Thanks to Marshall Huss][liftoff#142], [Juan Pablo Civile][liftoff#170],
  and [Keith Smiley][liftoff#160])
* Add default storyboard file. Liftoff will now generate an empty storyboard
  file for use in the project. - [Gordon Fontenot][liftoff#177]
* Add support for the new Launch Screen xib files. Liftoff will now generate
  an empty `LaunchScreen.xib` file and use it as the default launch screen
  option. - [Gordon Fontenot][liftoff#178] (lol recruiters)
* Let users customize Xcode open command. This lets you override the default
  command used to launch Xcode inside your liftoffrc. This means you can
  default to opening Vim, AppCode, beta versions of Xcode, or even disable the
  feature completely. - [Gordon Fontenot][liftoff#172] ([Thanks to
  @asmod3us][liftoff#166])

[liftoff#175]: https://github.com/thoughtbot/liftoff/issues/175
[liftoff#174]: https://github.com/thoughtbot/liftoff/issues/174
[liftoff#142]: https://github.com/thoughtbot/liftoff/issues/142
[liftoff#170]: https://github.com/thoughtbot/liftoff/issues/170
[liftoff#160]: https://github.com/thoughtbot/liftoff/issues/160
[liftoff#177]: https://github.com/thoughtbot/liftoff/issues/177
[liftoff#178]: https://github.com/thoughtbot/liftoff/issues/178
[liftoff#172]: https://github.com/thoughtbot/liftoff/issues/172
[liftoff#166]: https://github.com/thoughtbot/liftoff/issues/166

### Changes ###

* Update objc default project template - [Gordon Fontenot][liftoff#180]
* Simplify the status output. Liftoff no longer prints every file/directory it
  touches. Instead, it confirms that it's using the designated template. -
  [Gordon Fontenot][liftoff#179]
* Rename Info.plist template. This is to keep Liftoff's defaults in line with
  Xcode's. This template is now simply named `Info.plist` - [Gordon
  Fontenot][liftoff#175]
* Bump deployment target to 8.0. Welcome to the future. - [Gordon
  Fontenot][liftoff#176]

[liftoff#180]: https://github.com/thoughtbot/liftoff/issues/180
[liftoff#179]: https://github.com/thoughtbot/liftoff/issues/179
[liftoff#175]: https://github.com/thoughtbot/liftoff/issues/175
[liftoff#176]: https://github.com/thoughtbot/liftoff/issues/176

### Bug Fixes ###

- OS 10.10 support. - [Gordon Fontenot][liftoff#173]

[liftoff#173]: https://github.com/thoughtbot/liftoff/issues/173

## Liftoff 1.3 - 16 May 2014 ##

### New Features ###

* Install arbitrary template files in the project directory. You can use the
  new `templates` key in `.liftoffrc` to define arbitrary templates that
  should be installed in the project directory. Liftoff will install these
  templates relative to the project's root. - [Gordon Fontenot][liftoff#147]
  ([Thanks to James Frost][liftoff#146])
* Add Travis configuration by default. Liftoff will now generate the template
  files required for Travis to work out of the box. This can be disabled by
  overriding the templates we install by default - [Gordon
  Fontenot][liftoff#152]
* Add `setup`, `test`, and `README` templates to the project. - [Gordon
  Fontenot][liftoff#154]

[liftoff#147]: https://github.com/thoughtbot/liftoff/issues/147
[liftoff#146]: https://github.com/thoughtbot/liftoff/issues/146
[liftoff#152]: https://github.com/thoughtbot/liftoff/issues/152
[liftoff#154]: https://github.com/thoughtbot/liftoff/issues/154

### Changes ###

* Generated scheme is now shared. Previously, Xcode was creating a private
  scheme after the project was opened for the first time. We are now creating
  this scheme ourselves, and making it shared. - [Gordon
  Fontenot][liftoff#153] ([Thanks to Mark Adams][liftoff#70])
* Add OHHTTPStubs as a default testing dependency - [Gordon
  Fontenot][liftoff#143]
* Add documentation hint to default Podfile. This is intended to solve some
  confusion about where to add new pods after initial installation - [Gordon
  Fontenot][liftoff#145] ([Thanks to Mark Flowers][liftoff#144])

[liftoff#153]: https://github.com/thoughtbot/liftoff/issues/153
[liftoff#70]: https://github.com/thoughtbot/liftoff/issues/70
[liftoff#143]: https://github.com/thoughtbot/liftoff/issues/143
[liftoff#145]: https://github.com/thoughtbot/liftoff/issues/145
[liftoff#144]: https://github.com/thoughtbot/liftoff/issues/144

### Bug Fixes ###

* Don't skip installation for app targets. Previously, we were setting
  `SKIP_INSTALLATION` to `YES`, which caused the Archive action to fail
  silently. This change brings us back in line with Xcode's default behavior.
  - [Gordon Fontenot][liftoff#151] ([Thanks to James Frost][liftoff#149])

[liftoff#151]: https://github.com/thoughtbot/liftoff/issues/151
[liftoff#149]: https://github.com/thoughtbot/liftoff/issues/149

## Liftoff 1.2 - March 28, 2014 ##

### New Features ###

* Add command line flags. You can now pass a set of flags to the `liftoff`
  executable to override specific configurations at run time - [JP
  Simard][liftoff#126]
* Add `strict_prompts` option. This configuration option and the corresponding
  `--[no-]strict-prompts` command line flag tell `liftoff` to only prompt you
  for options that don't have default values set. This allows you to set values
  at run time and skip the prompt altogether. - [JP Simard][liftoff#127]
* Add configuration for setting up Run Script phases. This replaces the
  `install_todo_script` configuration key with a much more flexible
  `run_script_phases` key. By overriding this key, you can install any
  arbitrary script phases as long as you're providing a template for them.
  - [Mikael Bartlett][liftoff#120] ([Thanks to Magnus Ottosson][liftoff#118])
* Reluctantly allow the use of tabs for indentation. Even though my conscience
  protested, we've added a `use_tabs` key to the configuration. Enabling this
  will configure the project to use tabs instead of spaces. Note that this
  doesn't change the spacing in the default templates, so if you override this
  you will probably want to override those as well. - [Gordon
  Fontenot][liftoff#125] ([Thanks to Magnus Ottosson][liftoff#119])

[liftoff#126]: https://github.com/thoughtbot/liftoff/issues/126
[liftoff#127]: https://github.com/thoughtbot/liftoff/issues/127
[liftoff#120]: https://github.com/thoughtbot/liftoff/issues/120
[liftoff#125]: https://github.com/thoughtbot/liftoff/issues/125
[liftoff#118]: https://github.com/thoughtbot/liftoff/issues/118
[liftoff#119]: https://github.com/thoughtbot/liftoff/issues/119

### Changes ###

* Enable some more warnings by default. - [Gordon Fontenot][liftoff#134]
* Handle key deprecations a bit more gracefully. - [Gordon
  Fontenot][liftoff#133]
* Stop treating all plists as though they are the Info.plist. Previously, any
  plist that was added as a template was being treated as though it was the
  Info.plist for that target. We're now being more explicit about matching that
  file, and linking all other plists properly. - [Gordon Fontenot][liftoff#122]
  ([Thanks to @mattyohe][liftoff#121])

[liftoff#134]: https://github.com/thoughtbot/liftoff/issues/134
[liftoff#133]: https://github.com/thoughtbot/liftoff/issues/133
[liftoff#122]: https://github.com/thoughtbot/liftoff/issues/122
[liftoff#121]: https://github.com/thoughtbot/liftoff/issues/121

### Bug Fixes ###

* Set the deployment target at the project level. This mimics the behavior
  when creating a new project with Xcode. - [Gordon Fontenot][liftoff#123]

[liftoff#123]: https://github.com/thoughtbot/liftoff/issues/123

## Liftoff 1.1.1 - March 18, 2014 ##

### Bug Fixes ###

* Remove `OTHER_LDFLAGS` setting from app target. This was being set to a
  blank string, which caused it to override any xcconfig files added to the
  target. - Gordon Fontenot ([Thanks to @frosty][liftoff#111])
* Prevent RubyGems from loading. In some installs, users were seeing crashes
  due to the wrong Xcodeproj native C extensions being loaded. Current theory
  is that RVM is doing some loadpath stuff for gems that is overriding our
  loadpaths. The simple fix that seems to solve the issue is to completely
  disable RubyGems while running Liftoff. - Gordon Fontenot ([Thanks to
  @iOSDevil, Jim Rutherford, and @endoze][liftoff#113])

[liftoff#111]: https://github.com/thoughtbot/liftoff/issues/111
[liftoff#113]: https://github.com/thoughtbot/liftoff/issues/113

## Liftoff 1.1 - March 14, 2014 ##

### New Features ###

* Allow users to override templates. Now users can create templates inside
  `.liftoff/templates` at the local or user level in order to add custom
  templates, or override the default templates. - Gordon Fontenot
* Add support for CocoaPods. By default, Liftoff will generate a default
  podfile, and run `pod install` inside the project directory. This can be
  disabled inside the `.liftoffrc`. - JP Simard
* Add default pods for test target. By default, Liftoff will install `Specta`,
  `Expecta`, and `OCMock` for the test target. This can be overridden by using
  a custom template for the `Podfile` - Gordon Fontenot
* Add `company_identifier` property to configuration. We will now prompt for
  the company identifier on new project creation. The default for this prompt
  is generated by normalizing the provided company name, unless there is a
  default set by the `.liftoffrc` - Gordon Fontenot ([Thanks to Tony
  DiPasquale][liftoff#94])
* Open new projects after creation - Mark Adams

[liftoff#94]: https://github.com/thoughtbot/liftoff/issues/94

### Changes ###

* Application target defaults to portrait orientation only. - Mark Adams
* Automatically default to the current user's name. We no longer prompt for
  the user's name, instead defaulting to the name provided by the system. This
  can still be overridden by a `.liftoffrc` - Gordon Fontenot (Thanks to [Mike
  Burns][liftoff#80])
* Remove explicit framework linking. Since modules are enabled, we don't need
  to manually link frameworks anymore. - Gordon Fontenot
* Prefer new @import over #import - Mark Adams

[liftoff#80]: https://github.com/thoughtbot/liftoff/issues/80

### Bug Fixes ###

* Install ruby files into rubylib instead of lib. Previously, Homebrew was
  linking these into /usr/local/lib, which caused warnings when running `brew
  audit` - Gordon Fontenot ([Thanks to Ashton Williams][liftoff#107])
* Use `https` for GitHub URL in homebrew formula. This was causing warnings
  when running `brew audit` - Gordon Fontenot ([Thanks to Ashton Williams][liftoff#107])
* Print a nicer error if the directory exists. Previously, this was throwing
  an ugly ruby stack trace. - Gordon Fontenot ([Thanks to Mark
  Adams][liftoff#87])
* Trap interrupt during option input. Previously, this was throwing an ugly
  ruby stack trace. - Gordon Fontenot ([Thanks to George
  Brocklehurst][liftoff#81])
* Set SDKROOT at the project level - Gordon Fontenot ([Thanks to Tony
  DiPasquale][liftoff#97])

[liftoff#107]: https://github.com/thoughtbot/liftoff/issues/107
[liftoff#87]: https://github.com/thoughtbot/liftoff/issues/87
[liftoff#81]: https://github.com/thoughtbot/liftoff/issues/81
[liftoff#97]: https://github.com/thoughtbot/liftoff/issues/97

## Liftoff 1.0 - March 7, 2014 ##

Initial 1.0 release. See [blog post][liftoff-release] for details.

[liftoff-release]: http://robots.thoughtbot.com/liftoff-10
