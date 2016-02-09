#Fuubar

[![Gem Version](https://badge.fury.io/rb/fuubar.svg)](https://badge.fury.io/rb/fuubar) [![Build Status](https://secure.travis-ci.org/thekompanee/fuubar.svg?branch=master)](http://travis-ci.org/thekompanee/fuubar) [![Code Climate](https://codeclimate.com/github/thekompanee/fuubar.svg)](https://codeclimate.com/github/thekompanee/fuubar) [![Code Climate](https://codeclimate.com/github/thekompanee/fuubar/coverage.svg)](https://codeclimate.com/github/thekompanee/fuubar)

Fuubar is an instafailing [RSpec](http://github.com/rspec) formatter that uses a progress bar instead of a string of letters and dots as feedback.

[![gif](http://i.imgur.com/GIiA53s.gif)](http://vimeo.com/16845253).

Supported Rubies
--------------------------------
* MRI Ruby 1.8.7
* MRI Ruby 1.9.2
* MRI Ruby 1.9.3
* MRI Ruby 2.0.0
* MRI Ruby 2.1.0
* JRuby (in 1.8 compat mode)
* JRuby (in 1.9 compat mode)

Installation
--------------------------------------------------------------------------------

First:

```ruby
gem install fuubar
```

or in your Gemfile

```ruby
gem 'fuubar'
```

Then, when running rspec:

```
rspec --format Fuubar --color spec
```

Or, if you want to use Fuubar as your default formatter, simply put the options in your `.rspec` file:

    --format Fuubar
    --color

Advanced Usage
--------------------------------

### Customizing the Bar ###

Fuubar exposes an RSpec configuration variable called `fuubar_progress_bar_options` which, when set will be passed directly to [ruby-progressbar](https://github.com/jfelchner/ruby-progressbar) which does all the heavy lifting.  Take a look at the documentation for details on all of the options you can pass in.

Let's say for example that you would like to change the format of the bar. You would do that like so:

```ruby
# spec_helper.rb

RSpec.configure do |config|
  config.fuubar_progress_bar_options = { :format => 'My Fuubar! <%B> %p%% %a' }
end
```

would make it so that, when Fuubar is output, it would look something like:

    My Fuubar! <================================                  > 53.44% 00:12:31

Issues
--------------------------------

If you have problems, please create a [Github issue](https://github.com/jeffkreeftmeijer/fuubar/issues).

Credits
--------------------------------

fuubar was created by [Jeff Kreeftmeijer](https://github.com/jeffkreeftmeijer)
fuubar is maintained by [Jeff Kreeftmeijer](https://github.com/jeffkreeftmeijer) and [The Kompanee, Ltd.](http://www.thekompanee.com)

Contributing
--------------------------------------------------------------------------------

Found an issue? Have a great idea? Want to help? Great! Create an issue [issue](http://github.com/jeffkreeftmeijer/fuubar/issues) for it, or even better; fork the project and fix the problem yourself. Pull requests are always welcome. :)

License
--------------------------------

fuubar is Copyright &copy; 2010-2013 Jeff Kreeftmeijer and Jeff Felchner. It is free software, and may be redistributed under the terms specified in the LICENSE file.
