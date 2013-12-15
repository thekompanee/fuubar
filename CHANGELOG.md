Changelog
================================================================================

v1.3.0
--------------------------------------------------------------------------------
* Removed rspec_instafail as a dependency and used the RSpec formatter's
  built-in capabilities
* Update LICENSE
* Throttle the rate at which the bar is output to (at most) once per second if
  the CONTINUOUS_INTEGRATION environment variable is set
* Force colors to be disabled if the CONTINUOUS_INTEGRATION environment variable
  is set
* Enable Fuubar for RSpec 3 projects
