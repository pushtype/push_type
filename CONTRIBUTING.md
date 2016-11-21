# How to contribute to PushCode

Firstly, thank you! It's great that you're interested in contributing. PushType is 100% free and open source, and we're working hard to establish an active and healthy community of individuals contributing to it's development.

The following is a set of guidelines for contributing to PushType. Don't worry, there are no hard and fast rules, but please do take a moment to read through these guidelines so you know where to start and how we roll.

## Code of conduct

This project adheres to the Contributor Covenant [code of conduct](https://github.com/pushtype/push_type/blob/master/.github/CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

## Reporting issues

[The Github issue list](https://github.com/pushtype/push_type/issues) is **exclusively** for reporting bugs and tracking planned features and enhancements. For beginner questions, support, or to suggest and discuss new features, please use the official [PushType community discussion site](https://discuss.pushtype.org/).

* Try searching first to see if the same problem has already been reported. If it has, add a comment to the existing issue instead of opening a new one.
* Provide a clear and descriptive title for the issue to help identify the problem.
* Describe the exact steps necessary to reproduce the problem.
* Explain the behaviour you expected to see following the steps, and describe the behaviour you observed instead and why this is a problem.
* Copy and paste any errors from the application log or the web browser console in to the issue report.
* Please format any errors or code snippets using [Markdown code blocks](https://help.github.com/articles/basic-writing-and-formatting-syntax/#quoting-code).
* Include relevant details about your configuration and environment such as Ruby, Rails and PushType versions, and if necessary your browser and operating system.

## Suggesting improvements

Please do not open an issue on GitHub to suggest new features and improvements to PushType. Instead, share your ideas in the [PushType community feature category](https://discuss.pushtype.org/c/feature) and engage with the other developers and users.

Try searching first to check your idea hasn't already been discussed. Also, check the [PushType roadmap](https://discuss.pushtype.org/t/pushtype-development-roadmap/31) in case it's already in the pipeline.

Keep in mind that not every feature is destined to be in PushType. So, before jumping in and writing code, discuss your idea with the community, establish a desire for the development and a broad consensus for how it should be approached.

For accepted and planned features, GitHub issues will be created to track the work. Larger more complex developments may be broken down in to smaller issues and organised in a [GitHub project](https://github.com/pushtype/push_type/projects).

## Finding something to work on

So, you're ready to start contributing to PushType but unsure where to begin? You can start by [filtering through the Github issue list](https://github.com/pushtype/push_type/issues).

* [Beginner issues](https://github.com/pushtype/push_type/issues?q=is%3Aopen+is%3Aissue+label%3Abeginner+sort%3Acomments-desc) - issues that should be relatively simple to address in a few lines of code.
* [Help wanted issues](https://github.com/pushtype/push_type/issues?q=is%3Aopen+is%3Aissue+label%3Ahelp-wanted+sort%3Acomments-desc) - more involved issues, often where specific expertise is needed.

If you feel there's something you can help out with, let someone know by posting a comment and explaining how you intend to resolve the issue. Once the issue has been assigned to you, it's all yours 🙌.

## Helping with larger features and projects

If you would like to get more involved and help steer the design and development of PushType, then head over to the official [PushType community site](https://discuss.pushtype.org/) and introduce yourself.

* [PushType Roadmap](https://discuss.pushtype.org/t/pushtype-development-roadmap/31) - this wiki topic lists features that are either planned for the next releases or on the wishlist.
* [Features category](https://discuss.pushtype.org/c/feature) - contribute to these discussions and argue for (or against) proposed features and flesh them out in to workable specs.
* [Dev category](https://discuss.pushtype.org/c/dev) - Find out more about working on PushType, configuring development environments, coding conventions and so forth.

## Development setup

PushType consists of four separate Rails engines, each of which are published as gems:

* `PushType::Core`
* `PushType::Api`
* `PushType::Admin`
* `PushType::Auth`

The [Github repo](https://github.com/pushtype/push_type) contains the code for all of the above engines. At the root of the project is the gemspec for the main `push_type` gem. This is a simple wrapper for the four separate gems.

In each of the "admin", "api", "auth" and "core" directories is the code and gemspecs for the respective Rails engines.

### Installing Ruby and Node dependencies

After cloning the repository, install the gem dependencies for each of the Gemfiles:

```
> for d in core admin api auth; do cd $d && bundle install && cd ..; done
> bundle install
```

The "admin" engine uses webpack to build the front end assets. Once the JavaScript dependencies have been installed, a rake task can be used to run webpack.

```
> cd admin
> npm install
> rake webpack
```

### Running tests

From the project root you can run the entire project test suite. This iterates through each of the gem directories and runs their respective tests.

```
> rake test
```

Within any of the four gem directories, there are two test tasks:

* `rake test_app` - Removes and regenerates the dummy test app.
* `rake test` - Runs the test suite for that gem.

Whilst working on PushType, it can be useful to run the dummy test app server and view it in the browser as you make changes and write new code.

## Tests

All new features and improvements require test coverage. The test suite uses the minitest framework and is written in the spec style.

Be pragmatic with testing. Writing tests shouldn't be a major chore, and not every line of code requires test coverage. But the test suite should offer assurances that the new features and changes work under as many foreseeable circumstances as practical.

Prefer smaller shallow tests over deep (and possibly brittle) tests. The test suite should be fast, easy to reason with, and reliable.

## Pull requests

TBC...