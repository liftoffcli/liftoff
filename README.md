# Liftoff [![Gem Version](https://badge.fury.io/rb/liftoff.png)](http://badge.fury.io/rb/liftoff)

**Liftoff is a CLI for configuring opinionated defaults for new Xcode projects.**

* Add default .gitignore and .gitattributes files. Read more about this in our blog post: [Xcode and git: bridging the gap][xcode-gitattributes]
* Set the indentation level (4 spaces by default. No tabs, the way God intended)
* Treat warnings as errors for release schemes
* Enable [Hosey-level warnings][hosey-warnings] at the project level
* Turn on Static Analysis for the project
* Add a build phase shell script that [turns "TODO:" and "FIXME:" into warnings][deallocated-todo]

[xcode-gitattributes]: http://robots.thoughtbot.com/post/33796217972/xcode-and-git-bridging-the-gap
[deallocated-todo]: http://deallocatedobjects.com/posts/show-todos-and-fixmes-as-warnings-in-xcode-4
[hosey-warnings]: http://boredzo.org/blog/archives/2009-11-07/warnings

## Installation

    $ gem install liftoff

## Usage

Liftoff adds the `liftoff` command to your PATH. These commands are meant to be run in directories containing existing Xcode projects.

```
$ liftoff

    CLI for customizing new Xcode projects

    Commands:
      all                  Run all possible commands. (Default)
      git                  Add default .gitignore and .gitattributes files.
      indentation          Set project indentation level.
      releasewarnings      Treat all warnings as errors in release schemes.
      todo                 Add a build script to treat TODO and FIXME as warnings.
      warnings             Enable Hosey warnings.
      analyzer             Enable Static Analysis for the project.
      help                 Display global or [command] help documentation.

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

Liftoff is Copyright (c) 2012-2013 thoughtbot, inc. It is free software, and may be redistributed under the terms specified in the LICENSE file.
