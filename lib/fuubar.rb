require 'rspec/core/configuration'
require 'rspec/core/formatters/base_text_formatter'
require 'ruby-progressbar'

RSpec.configuration.add_setting :fuubar_progress_bar_options, :default => {}

class Fuubar < RSpec::Core::Formatters::BaseTextFormatter
  DEFAULT_PROGRESS_BAR_OPTIONS = { :format => ' %c/%C |%w>%i| %e ' }

  attr_accessor :progress

  def initialize(*args)
    super

    progress_bar_options =  DEFAULT_PROGRESS_BAR_OPTIONS.
                              merge(configuration.fuubar_progress_bar_options).
                              merge(:total     => example_count,
                                    :output    => output,
                                    :autostart => false)

    self.progress = ProgressBar.create(progress_bar_options)
  end

  def start(example_count)
    super

    progress.total = example_count

    with_current_color { progress.start }
  end

  def example_passed(example)
    super

    increment
  end

  def example_pending(example)
    super

    increment
  end

  def example_failed(example)
    super

    progress.clear

    dump_failure    example, failed_examples.size - 1
    dump_backtrace  example

    output.puts

    increment
  end

  def message(string)
    if progress.respond_to? :log
      progress.log(string)
    else
      super
    end
  end

  def dump_failures
    #
    # We output each failure as it happens so we don't need to output them en
    # masse at the end of the run.
    #
  end

  private

  def increment
    with_current_color { progress.increment }
  end

  def with_current_color
    output.print "\e[#{color_code_for(current_color)}m" if color_enabled?
    yield
    output.print "\e[0m"                                if color_enabled?
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
end
