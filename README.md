# <img src="http://thoughtbot.github.io/liftoff/logo.png" alt="Logo" width="25%">

**Liftoff is a CLI for creating and configuring iOS Xcode projects.**

## Installation

    brew tap thoughtbot/formulae
    brew install liftoff

Liftoff was previously distributed via RubyGems. This method of installation has
been deprecated, and all new releases will be done through Homebrew. If you are
migrating from RubyGems, you should uninstall the gem version to avoid confusion
in the future.

## Usage

Run this command in a directory

    liftoff

View the documentation:

    man liftoff
    man liftoffrc

When Liftoff finds an existing project in the current directory, it will
perform the following configurations:

* Set the indentation level (In spaces, 4 by default).
* Treat warnings as errors for release schemes.
* Enable warnings at the project level, check `liftoffrc(5)` for a list of the warnings.
* Turn on Static Analysis for the project.
* Add a build phase shell script that [turns "TODO:" and "FIXME:" into
  warnings][deallocated-todo].
* Add a build phase shell script that sets the version to the latest Git tag,
  and the build number to the number of commits on master.
* Add default [.gitignore] and [.gitattributes] files.
* Initialize a new `git` repo and create an initial commit (if needed).

[.gitignore]: https://github.com/thoughtbot/liftoff/blob/master/templates/gitignore
[.gitattributes]: https://github.com/thoughtbot/liftoff/blob/master/templates/gitattributes
[deallocated-todo]: http://deallocatedobjects.com/posts/show-todos-and-fixmes-as-warnings-in-xcode-4

When you run Liftoff in a directory without a project file, it will create a
new directory structure for a project, and generate a well-configured Xcode
project in that subdirectory:

```
$ cd ~/dev/
$ liftoff
Project name? MyCoolApp
Company name? thoughtbot
Author name? Gordon Fontenot
Prefix? MCA
Creating MyCoolApp
Creating MyCoolApp/Categories
Creating MyCoolApp/Classes
[snip]
```

Liftoff will generate a brand new project for you based on the provided
values. Generating projects via Liftoff has these advantages:

* Minimized time reorganizing the repository
* Sets up `git` repository automatically
* Defined group structure
* Matching directory structure on disk (linked to the proper group)
* Easily customizable
* Configurations can be shared easily

### Configuration

You can use a `liftoffrc` file to speed up your workflow by defining your
preferred configuration for Liftoff.

Liftoff will look for config files in the local directory and then the home
directory. If it can't find a key in `./.liftoffrc` or `~/.liftoffrc`, it will
use the default values. Check `liftoffrc(5)` for more information:

    man liftoffrc

You can see the [current liftoffrc on master][liftoffrc], but be aware that
the keys might not match up completely with the current released version.

[liftoffrc]: https://github.com/thoughtbot/liftoff/blob/master/defaults/liftoffrc

### Directory Structure and Templates

One of the most powerful things that Liftoff can do for you is let you quickly
and easily customize your project's group and directory structure. By defining
a YAML dictionary inside your local or user `.liftoffrc`, you can completely
dictate the structure that will be created. This includes group structure,
order, placement of template files, etc. And remember that these groups will
be mimicked on disk as well.

You can also create your own templates, or override the defaults by adding
them to `~/.liftoff/templates` or `./.liftoff/templates`. Liftoff will use the
same fallback order when looking for templates as it does for the
`.liftoffrc`.

These files (and filenames) will be parsed with `ERB`, using the values
provided at run time (or the default values from a `liftoffrc`).

## About

Liftoff is maintained by Mark Adams and Gordon Fontenot. It was written by
[thoughtbot, inc](http://thoughtbot.com/).

![thoughtbot](http://thoughtbot.com/images/tm/logo.png)

The names and logos for thoughtbot are trademarks of thoughtbot, inc.

## License

Liftoff is Copyright (c) 2012-2014 thoughtbot, inc. It is free software, and
may be redistributed under the terms specified in the LICENSE file.
