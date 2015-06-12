# Contributing to liftoff

We love pull requests from everyone. Follow the thoughtbot [code of conduct]
while contributing.

[code of conduct]: https://thoughtbot.com/open-source-code-of-conduct

## Contributing a feature

We love pull requests. Here's a quick guide:

1. Clone the repo:

        git clone https://github.com/thoughtbot/liftoff.git

2. Run the tests. We only take pull requests with passing tests, and it's great
   to know that you have a clean slate:

        bundle
        rspec

3. Add a test for your change. Only refactoring and documentation changes
   require no new tests. If you are adding functionality or fixing a bug, we
   need a test!

4. Make the test pass.

5. Fork the repo, push to your fork, and submit a pull request.

At this point you're waiting on us. We like to at least comment on, if not
accept, pull requests within three business days. We may suggest some changes or
improvements or alternatives.

Some things that will increase the chance that your pull request is accepted:

* Include tests that fail without your code, and pass with it.
* Update the documentation, especially the man page, whatever is affected by
  your contribution.
* Follow the [thoughtbot style guide][style-guide].

And in case we didn't emphasize it enough: we love tests!

## Releasing a new version

liftoff's packaging is handled through a series of Rake tasks

1. Update the version number in `lib/liftoff/version.rb`.

2. Vendorize the gem dependencies:

        rake gems:vendorize

3. Build and publish the release:

        rake release:build
        rake release:push
        rake release:clean

    Alternatively, you can use a single command that will run steps 2 and 3 for
    you. If anything goes wrong, this will be harder to debug:

        ./release.sh

[style-guide]: https://github.com/thoughtbot/guides/tree/master/style#ruby
