require 'rspec'
require 'rspec/core/formatters/base_text_formatter'
require 'ruby-progressbar'

RSpec.configuration.add_setting :fuubar_progress_bar_options, :default => {}

class Fuubar < RSpec::Core::Formatters::BaseTextFormatter

  if RSpec::Core::Formatters.respond_to? :register
    RSpec::Core::Formatters.register self,
      :message, :example_passed, :example_pending, :example_failed
  end

  DEFAULT_PROGRESS_BAR_OPTIONS = { :format => ' %c/%C |%w>%i| %e ' }

  attr_accessor :progress, :example_count

  def initialize(*args)
    super

    progress_bar_options =  DEFAULT_PROGRESS_BAR_OPTIONS.
                              merge(:throttle_rate  => continuous_integration? ? 1.0 : nil).
                              merge(configuration.fuubar_progress_bar_options).
                              merge(:total          => example_count,
                                    :output         => output,
                                    :autostart      => false)

    self.progress = ProgressBar.create(progress_bar_options)
  end

  def start(notification)
    example_count = compatible notification, :count

    super

    progress.total = example_count

    with_current_color { progress.start }
  end

  def example_passed(notification)
    super if defined?(super)

    increment
  end

  def example_pending(notification)
    super

    increment
  end

  def example_failed(notification)
    example = compatible notification, :example

    super

    progress.clear

    dump_failure    example, failed_examples.size - 1
    dump_backtrace  example

    output.puts

    increment
  end

  def message(notification)
    string = compatible notification, :message

    if progress.respond_to? :log
      progress.log(string)
    else
      super
    end
  end

  def dump_failures(notification=nil)
    #
    # We output each failure as it happens so we don't need to output them en
    # masse at the end of the run.
    #
    # No need in this since RSpec 3.x
    #
  end

  private

  # since RSpec 3.x use Notificaton as param class
  def compatible(param, method)
    if param.respond_to? method
      param.send method
    else
      param
    end
  end

  def increment
    with_current_color { progress.increment }
  end

  def with_current_color
    output.print "\e[#{color_code_for(current_color)}m" if color_enabled?
    yield
    output.print "\e[0m"                                if color_enabled?
  end

  def color_enabled?
    super && !continuous_integration?
  end

  def current_color
    if failed_examples.size > 0
      configuration.failure_color
    elsif pending_examples.size > 0
      configuration.pending_color
    else
      configuration.success_color
    end
  end

  def continuous_integration?
    @continuous_integration ||= !(ENV['CONTINUOUS_INTEGRATION'].nil? || ENV['CONTINUOUS_INTEGRATION'] == '' || ENV['CONTINUOUS_INTEGRATION'] == 'false')
  end
end
