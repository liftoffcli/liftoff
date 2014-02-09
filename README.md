# Liftoff [![Gem Version](https://badge.fury.io/rb/liftoff.png)](http://badge.fury.io/rb/liftoff)

**Liftoff is a CLI for configuring opinionated defaults for new Xcode projects.**

* Add default .gitignore and .gitattributes files. Read more about this in our blog post: [Xcode and git: bridging the gap][xcode-gitattributes]
* Set the indentation level (4 spaces by default. No tabs, the way God intended)
* Treat warnings as errors for release schemes
* Enable warnings at the project level
* Turn on Static Analysis for the project
* Add a build phase shell script that [turns "TODO:" and "FIXME:" into warnings][deallocated-todo]

[xcode-gitattributes]: http://robots.thoughtbot.com/post/33796217972/xcode-and-git-bridging-the-gap
[deallocated-todo]: http://deallocatedobjects.com/posts/show-todos-and-fixmes-as-warnings-in-xcode-4

## Installation

    $ gem install liftoff

## Usage

Run this command in a directory containing an Xcode project:

    $ liftoff

### Configuration - .liftoffrc

You can use the `.liftoffrc` file to speed up your workflow by defining your
favorite settings for liftoff. Liftoff will look for config files in the local
directory and then the home directory. If you haven't provided a
`./.liftoffrc` or a `~/.liftoffrc`, it will use [the default](https://github.com/thoughtbot/liftoff/blob/master/defaults/liftoffrc).
Check the default for a list of available options.

## About

The liftoff gem is maintained by Mark Adams and Gordon Fontenot. It was written by [thoughtbot, inc](http://thoughtbot.com/).

![thoughtbot](http://thoughtbot.com/images/tm/logo.png)

The names and logos for thoughtbot are trademarks of thoughtbot, inc.

## License

Liftoff is Copyright (c) 2012-2014 thoughtbot, inc. It is free software, and may be redistributed under the terms specified in the LICENSE file.
