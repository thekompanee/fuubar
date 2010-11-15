require 'rspec/core/formatters/base_text_formatter'
require 'progressbar'

class Fuubar < RSpec::Core::Formatters::BaseTextFormatter

  attr_reader :example_count, :finished_count
  COLORS = { :green =>  "\e[32m", :yellow => "\e[33m", :red => "\e[31m" }

  def start(example_count)
    @example_count = example_count
    @finished_count = 0
    @progress_bar = ProgressBar.new("#{example_count} examples", example_count, output)
  end

  def increment
    with_color do
      @finished_count += 1
      @progress_bar.inc
      @progress_bar.instance_variable_set("@title", "#{finished_count}/#{example_count}")
    end
  end

  def example_passed(example)
    super
    increment
  end

  def example_pending(example)
    super
    @state = :yellow unless @state == :red
    increment
  end

  def example_failed(example)
    super
    @state = :red
    increment
  end

  def with_color
    output.print COLORS[state]
    yield
    output.print "\e[0m"
  end

  def state
    @state ||= :green
  end

end
