# Liftoff

**Liftoff is a CLI for configuring sensible defaults for new Xcode projects.**

* Add default .gitignore and .gitattributes files. [Xcode and git: bridging the gap](http://robots.thoughtbot.com/post/33796217972/xcode-and-git-bridging-the-gap).
* Treat warnings as errors for release schemes.
* Enable all warnings.
* Add a build phase shell script that [turns "TODO:" and "FIXME:" into warnings](http://deallocatedobjects.com/posts/show-todos-and-fixmes-as-warnings-in-xcode-4).

## Installation

    $ gem install liftoff

## Usage

Liftoff adds the `liftoff` command to your PATH. These commands are meant to be run in directories containing existing Xcode projects.

```
$ liftoff

    CLI for customizing new Xcode projects

    Commands:
      all                  Run all possible commands.               
      git                  Add default .gitignore and .gitattributes files.
      help                 Display global or [command] help documentation.
      releasewarnings      Treat all warnings as errors in release schemes.
      todo                 Add a build script to treat TODO and FIXME as warnings.
      warnings             Enable all warnings.

    Global Options:
      -h, --help           Display help documentation 
      -v, --version        Display version information 
      -t, --trace          Display backtrace when an error occurs 
```

## About

The liftoff gem is maintained by Mark Adams and Gordon Fontenot. It was written by [thoughtbot, inc](http://thoughtbot.com/).

![thoughtbot](http://thoughtbot.com/images/tm/logo.png)

The names and logos for thoughtbot are trademarks of thoughtbot, inc.

## License

Liftoff is Copyright (c) 2012 thoughtbot, inc. It is free software, and may be redistributed under the terms specified in the LICENSE file.
