Version v2.3.0 - December 31, 2017
================================================================================

Add
--------------------------------------------------------------------------------
  * Per-Second Bar Refresh for Long-Running Examples

Uncategorized
--------------------------------------------------------------------------------
  * Updated README to reflect supported Ruby versions.

Version v2.2.0 - August 23, 2016
================================================================================

  * travis CI: use container-based env, add jruby, `gem update` before testing
  * Add workaround for JRuby crash
  * Require only 'rspec/core' instead of full rspec

Version v2.1.1 - July 14, 2016
================================================================================

Fixed
--------------------------------------------------------------------------------
  * Explicitly require delegate

Version v2.1.0 - July 12, 2016
================================================================================

Changed
--------------------------------------------------------------------------------
  * RSpec dependency to support 3.5 final

Fixed
--------------------------------------------------------------------------------
  * Delegator not found

Version v2.1.0 - April 24, 2016
================================================================================

Added
--------------------------------------------------------------------------------
  * Certificate verification to the gem
  * Output module

Changed
--------------------------------------------------------------------------------
  * to use our custom Output object

Version v2.0.0 - August 7, 2014
================================================================================

Bugfix
--------------------------------------------------------------------------------
  * Fix duplicate constant warnings

Uncategorized
--------------------------------------------------------------------------------
  * update to rspec3 final

Version v2.0.0 - May 27, 2014
================================================================================

Feature
--------------------------------------------------------------------------------
  * Bump to Ruby 2.1.2 for development

Uncategorized
--------------------------------------------------------------------------------
  * Rewrite specs for RSpec 3.0.0.rc1
  * bundle update
  * Support and require RSpec 3.0.0.rc1

Version v2.0.0 - May 11, 2014
================================================================================

  * Create the bar after 'start' is called so that we can make sure that we get
    any of the custom options that could be passed in with the RSpec configuration
    value - Closes #65
  * Remove the intermediate 'progress' let call so we always get the most
    up-to-date one
  * Bump minimum ruby-progressbar version to 1.4 so we can get the '#started?'
    method
  * Add CodeClimate code coverage reporting
  * Fix badges due to repo move
  * Update badges
  * Update gemfiles and ruby version for the RSpec beta

Version v2.0.0 - January 31, 2014
================================================================================

  * Fix TravisCI link, Add RubyGems badge and add code climate badge to ReadMe
  * Switch to RSpec 3.0 compatible formatter
  * fix gem name
  * Added MRI 2.1.0 to README.md.
  * Added MRI 2.1.0 to .travis.yml.

Version v1.3.2 - December 16, 2013
================================================================================

  * Fix an issue whereby loading rspec-rails did not properly require RSpec

Version v1.3.1 - December 16, 2013
================================================================================

  * Fix issue where loading RSpec's configuration was causing issues when used
    with rake (due to the order of requirement)

Version v1.3.0 - December 15, 2013
================================================================================

  * Tell Travis which command to run
  * Update Travis config to test 1.8.7, 1.9.2 and JRuby
  * Long overdue README Update
  * Add CHANGELOG - Closes #46
  * Use Travis to test against multiple RSpec versions
  * Update RSpec dependency to work with RSpec 3.0
  * Disable colors if the CONTINUOUS_INTEGRATION environment variable is set
  * If continuous integration is set, the throttle rate should be set to 1
    second, otherwise just leave it at the default
  * Make sure that the default configuration options are set before each spec is
    run
  * Add continuous_integration to check if the CONTINUOUS_INTEGRATION
    environment variable is set
  * Upgrade ruby-progressbar with additional throttle logic
  * Remove the version file
  * Update Rakefile with bundler tasks for releasing gems
  * Remove spec_helper
  * Upgrade ruby-progressbar to the latest version
  * Add Gemfile.lock to the project
  * Add MIT License - Closes #42
  * Update gemspec
  * Big refactoring to use the capabilities exposed by RSpec's formatters as
    well as replacing the specs with ones which are more representative
  * Add .ruby-version file
  * Use RSpec's helpers to output the failures at the proper time
  * Remove all references to instafail
  * Remove rspec-instafail from the project

Version v1.2.1 - August 16, 2013
================================================================================

  * Delegate back up to the RSpec superclass if the reporter has yet to be
    started

Version v1.2.0 - August 15, 2013
================================================================================

  * Allow fuubar to send messages to the output stream
  * Print end color escape sequence only when colors are enabled.
  * Broken link removed.
  * Corrupt Travis CI Status Image fixed.
  * Loosen the version requirement of ruby-progressbar since it follows SemVer
  * Releasing 1.1.0
  * Update ruby-progressbar to 1.0.0
  * Releasing 1.1.0.rc1
  * Remove `start_dump` as it's no longer needed
  * Setting the example_count is handled in the super class and has been since
    v2.0 so we can just rely on calling `super`
  * Simplification now means we have a duplicate spec we can remove
  * ProgressBars finish themselves as soon as the progress equals the total so
    we no longer need to explicitly finish the bar
  * Now the the ProgressBar is in charge of keeping track of progress and total,
    we don't need to cross boundaries to spec this
  * Because we're using the formatters, we no longer have to manually update the
    counts after each increment
  * Use the new ruby-progressbar formatters for MOAR AWESOME!!!1!
  * The progress mark defaults to '=' in ruby-progressbar 1.0 so no need to set
    it in Fuubar
  * Update usages to the new ruby-progressbar syntax
  * Update ruby-progressbar to the 1.0 release candidate
  * Update legacy gem info in README
  * Update README ref to fuubar-legacy with a reminder to still require fuubar.
  * Add ref to fuubar-legacy gem in README
  * Fix the Travis build status image :)
  * Add the Travis build status badge
  * Remove the stillmaintained status badge
  * Releasing 1.0
  * Releasing 1.0.0.rc1
  * loosen instafail gem version req
  * bump instafail version
  * use let instead of instance variables
  * 0.0.6
  * Bump rspec-instafail to 0.1.8. Closes #12
  * Remove the outdated contributor link from the README
  * Releasing 0.0.5
  * Switch back to ruby-progressbar
  * Releasing 0.0.4
  * Temporarily(?) switch to chalofa_ruby-progressbar to fix issues with Spork.
    Closes #17
  * Remove Gemfile.lock and add it to .gitignore
  * Travis and Josh made me add a Rakefile
  * Require StringIO in fuubar_spec. Closes #3
  * Put Fuubar::COLORS in a method instead of a constant. Closes #15
  * Bump the version number to 0.0.3
  * Add the StillMaintained button to the README
  * Increment the progress bar before updating the title
  * Add the contributors line to the README
  * Bump the version number to 0.0.2
  * Link to Github as the "homepage" in the .gemspec
  * Add a spec for the bar_mark change
  * Minor cleaups for spec/fuubar_spec
  * Use ==== instead of oooo in the progress bar
  * Use ruby-progressbar instead of progressbar
  * Add .rspec to eat my own dogfood
  * Update Gemfile.lock
  * Move the title 2 spaces to the right
  * Require rspec-instafail ~> 0.1.4
  * Remove "--require fuubar" from the README
  * Linking to the video instead of embedding and using bc. blocks in the README
  * Wrap the video in the README in ===
  * Add the LITL license :)
  * Add README.textile
  * Update the .gemspec descriptions
  * remove the Rakefile
  * Use Instafail's example_failed method
  * Add instafail, start_dump and state
  * Add inrement and with_color
  * Add example_passed, example_pending, example_failed and state
  * Add Fuubar.start
  * Add RSpec and create /spec
  * Initial commit

