# Fuubar 
[![Still mantained?](http://stillmaintained.com/jeffkreeftmeijer/fuubar.png)](http://stillmaintained.com/jeffkreeftmeijer/fuubar)
[![Build Status](https://secure.travis-ci.org/jeffkreeftmeijer/fuubar.png?branch=legacy)](http://travis-ci.org/jeffkreeftmeijer/fuubar)

Fuubar is an instafailing [RSpec](https://github.com/dchelimsky/rspec) formatter that uses a progress bar instead of a string of letters and dots as feedback. Here's [a video of Fuubar in action](http://vimeo.com/16845253).

You're on the legacy branch that supports RSpec ~> 1.3 right now. There's an [RSpec 2.x branch](https://github.com/jeffkreeftmeijer/fuubar) too. :)

## Installation

Installing Fuubar is easy. Just put it in your `Gemfile`:

```ruby
gem 'fuubar-legacy'
```

And run your specs like this from now on:

```bash
$ spec --format Fuubar --color spec
```

If you want to use Fuubar as your default formatter, simply put the options in your `spec/spec.opts` file:

    --format Fuubar
    --color

## Contributing

Found an issue? Have a great idea? Want to help? Great! [Create an issue](http://github.com/jeffkreeftmeijer/fuubar/issues) for it, or even better; fork the project and fix the problem yourself. Pull requests are always welcome. :)

Yay for [Fuubar's awesome contributors](https://github.com/jeffkreeftmeijer/fuubar/wiki/Contributors)!
