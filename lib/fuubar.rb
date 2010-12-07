require 'spec/runner/formatter/base_formatter'
require 'progressbar'
require 'rspec/instafail'

class Fuubar < Spec::Runner::Formatter::BaseTextFormatter

  attr_reader :example_count, :finished_count
  COLORS = { :green =>  "\e[32m", :yellow => "\e[33m", :red => "\e[31m" }

  def start(example_count)
    @example_count = example_count
    @finished_count = 0
    @progress_bar = ProgressBar.new("  #{example_count} examples", example_count, output)
    @progress_bar.bar_mark = '='
  end

  def increment
    with_color do
      @finished_count += 1
      @progress_bar.instance_variable_set("@title", "  #{finished_count}/#{example_count}")
      @progress_bar.inc
    end
  end

  def example_passed(example)
    super
    increment
  end

  def example_pending(example, message)
    super
    @state = :yellow unless @state == :red
    increment
  end

  def example_failed(example, counter, message)
    super
    @state = :red

    output.print "\e[K"
    instafail.example_failed(example, counter, message)
    output.puts

    increment
  end

  def start_dump
    with_color { @progress_bar.finish }
  end

  def dump_failures
    # don't!
  end

  def instafail
    @instafail ||= RSpec::Instafail.new(@options, output)
    #since instafail won't be able to get the current example_group it must be
    #updated every time
    @instafail.example_group_started(example_group)
    @instafail
  end

  def with_color
    output.print COLORS[state] if colour?
    yield
    output.print "\e[0m"
  end

  def state
    @state ||= :green
  end

end
