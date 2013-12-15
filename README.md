Fuubar ![Travis CI Status](https://travis-ci.org/jeffkreeftmeijer/fuubar.png)
================================================================================

Fuubar is an instafailing [RSpec](http://github.com/rspec) formatter that uses a progress bar instead of a string of letters and dots as feedback. Here's [a video of Fuubar in action](http://vimeo.com/16845253).

Installation
--------------------------------------------------------------------------------

Installing Fuubar is easy. Just put it in your `Gemfile` and run your specs like this from now on:

```sh
rspec --format Fuubar --color spec
```

If you want to use Fuubar as your default formatter, simply put the options in your `.rspec` file:

    --format Fuubar
    --color

### Rspec-1 ###

Use the [fuubar-legacy](https://rubygems.org/gems/fuubar-legacy) gem:

```ruby
gem 'fuubar-legacy'
```

Contributing
--------------------------------------------------------------------------------

Found an issue? Have a great idea? Want to help? Great! Create an issue [issue](http://github.com/jeffkreeftmeijer/fuubar/issues) for it, or even better; fork the project and fix the problem yourself. Pull requests are always welcome. :)
