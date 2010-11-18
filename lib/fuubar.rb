module FuubarModule
  module FuubarBase
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
        @progress_bar.inc
        @progress_bar.instance_variable_set("@title", "  #{finished_count}/#{example_count}")
      end
    end

    def example_passed(example)
      super
      increment
    end

    def start_dump
      with_color { @progress_bar.finish }
    end

    def dump_failures
      # don't!
    end

    def with_color
      output.print COLORS[state] if color_enabled?
      yield
      output.print "\e[0m"
    end

    def state
      @state ||= :green
    end
  end

  module Fuubar_2_x
    include FuubarModule::FuubarBase
    
    def example_pending(example)
      super
      @state = :yellow unless @state == :red
      increment
    end

    def example_failed(example)
      super
      @state = :red

      output.print "\e[K"
      instafail.example_failed(example)
      output.puts

      increment
    end

    def instafail
      @instafail ||= RSpec::Instafail.new(output)
    end
  end

  module Fuubar_1_3_x
    include FuubarModule::FuubarBase

    #a message is required
    def example_pending(example_proxy, message)
      super
      @state = :yellow unless @state == :red
      increment
    end

    #a counter and a failure are required
    def example_failed(example_proxy, counter, failure)
      super
      @state = :red

      output.print "\e[K"
      instafail.example_failed(example_proxy, counter, failure)
      output.puts

      increment
    end
    
    #dump_failure with a counter and a failure is triggered
    #instead of dump_failures
    def dump_failure(counter, failure)
      dump_failures
    end

    #dump pending improvement from RSpec 2.x
    def dump_pending
      unless pending_examples.empty?
        output.puts
        output.puts "Pending:"
        pending_examples.each do |pending_example|
          output.puts yellow("  #{pending_example[0]}")
          output.puts grey("    # #{pending_example[1]}")
          output.puts grey("    # #{format_caller(pending_example[2])}")
        end
      end
    end

    def instafail
      @instafail ||= RSpec::Instafail.new(@options, output)
      #since instafail won't be able to get the current example_group it must be
      #updated every time
      @instafail.example_group_started(example_group)
      @instafail
    end
    #the following methods are not defined on Rspec 1.3.x
    #TODO: find equivalent Rspec 1.3.x methods to replace the Rspec 2.x copies

    def color_enabled?
      #TODO: find a way to validate if colors are enabled on Rspec 1.3.x
      true
    end

    def pending_examples
      @pending_examples
    end

    def yellow(text)
      color(text, "\e[33m")
    end

    def grey(text)
      color(text, "\e[90m")
    end

    def color(text, color_code)
      color_enabled? ? "#{color_code}#{text}\e[0m" : text
    end

    def format_caller(caller_info)
      backtrace_line(caller_info.to_s.split(':in `block').first)
    end

    def backtrace_line(line)
      #TODO: does Rspec 1.3.x support this option ?
      #   find a way to read the proper options and configure the filter
      #   :
      #   remove this method > remove format_caller method > remove format_caller
      #   calls within this module
      #
      #return nil if configuration.cleaned_from_backtrace?(line)
      line = line.sub(File.expand_path("."), ".")
      line = line.sub(/\A([^:]+:\d+)$/, '\\1')
      return nil if line == '-e:1'
      line
    end
  end
end

case Gem.loaded_specs["rspec"].version.to_s
  when /^2.*/ then
    require 'rspec/core/formatters/base_text_formatter'
    require 'progressbar'
    require 'rspec/instafail'
    class Fuubar < RSpec::Core::Formatters::BaseTextFormatter
      include FuubarModule::Fuubar_2_x
    end
  when /^1\.3.*/ then
    require 'spec/runner/formatter/base_text_formatter'
    require 'progressbar'
    require 'rspec/instafail'
    class Fuubar < Spec::Runner::Formatter::BaseTextFormatter
      include FuubarModule::Fuubar_1_3_x
    end
  else
    raise RuntimeError, "Your RSpec version is not supported. RSpec >= 3.1 is required."
end
