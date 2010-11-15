require 'rspec/core/formatters/base_text_formatter'
require 'progressbar'

class Fuubar < RSpec::Core::Formatters::BaseTextFormatter

  def start(example_count)
    @example_count = example_count
    @finished_count = 0
    @progress_bar = ProgressBar.new("#{example_count} examples", example_count, output)
  end

end
