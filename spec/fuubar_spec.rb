require 'fuubar'
require 'stringio'

describe Fuubar do
  let(:output) do
    io = StringIO.new

    allow(io).to  receive(:tty?).
                  and_return(true)

    io
  end

  let(:formatter) { Fuubar.new(output) }
  let(:example)   { RSpec::Core::ExampleGroup.describe.example }

  let(:failed_example) do
    exception = RuntimeError.new('Test Fuubar Error')
    exception.set_backtrace [
      "/my/filename.rb:4:in `some_method'",
    ]

    example = RSpec::Core::ExampleGroup.describe.example

    example.instance_variable_set(:@metadata, {
      :file_path        => '/my/example/spec.rb',
      :execution_result => {
        :exception => exception },
    } )

    example
  end

  let(:fuubar_results) do
    output.rewind
    output.read
  end

  before(:each) do
    RSpec.configuration.fuubar_progress_bar_options = {
      :length        => 40,
      :throttle_rate => 0.0,
    }

    ENV.delete('CONTINUOUS_INTEGRATION')
  end

  context 'when it is created' do
    it 'does not start the bar until the formatter is started' do
      expect(formatter.progress).not_to be_started

      formatter.start(2)

      expect(formatter.progress).to be_started
    end

    it 'creates a new ProgressBar' do
      expect(formatter.progress).to be_instance_of ProgressBar::Base
    end

    it 'sets the format of the bar to the default' do
      expect(formatter.progress.instance_variable_get(:@format_string)).to eql ' %c/%C |%w>%i| %e '
    end

    it 'sets the total to the number of examples' do
      expect(formatter.progress.total).to be_zero
    end

    it 'sets the bar\'s output' do
      expect(formatter.progress.send(:output)).to eql formatter.output
      expect(formatter.progress.send(:output)).to eql output
    end

    context 'and continuous integration is enabled' do
      before do
        RSpec.configuration.fuubar_progress_bar_options = {:length => 40}
        ENV['CONTINUOUS_INTEGRATION'] = 'true'
      end

      it 'throttles the progress bar at one second' do
        throttle      = formatter.progress.instance_variable_get(:@throttle)
        throttle_rate = throttle.instance_variable_get(:@period)

        expect(throttle_rate).to eql 1.0
      end

      context 'when processing an example' do
        before do
          throttle      = formatter.progress.instance_variable_get(:@throttle)
          throttle_rate = throttle.instance_variable_set(:@period, 0.0)

          formatter.start(2)

          output.rewind

          formatter.example_passed(example)
        end

        it 'does not output color codes' do
          expect(fuubar_results).to start_with " 1/2 |== 50 ==>        |  ETA: 00:00:00 \r"
        end
      end
    end

    context 'and continuous integration is not enabled' do
      before do
        RSpec.configuration.fuubar_progress_bar_options = {:length => 40}
        ENV['CONTINUOUS_INTEGRATION'] = 'false'
      end

      it 'throttles the progress bar at the default rate' do
        throttle      = formatter.progress.instance_variable_get(:@throttle)
        throttle_rate = throttle.instance_variable_get(:@period)

        expect(throttle_rate).to eql 0.01
      end

      context 'when processing an example' do
        before do
          throttle      = formatter.progress.instance_variable_get(:@throttle)
          throttle_rate = throttle.instance_variable_set(:@period, 0.0)

          formatter.start(2)

          output.rewind

          formatter.example_passed(example)
        end

        it 'does not output color codes' do
          expect(fuubar_results).to start_with "\e[32m 1/2 |== 50 ==>        |  ETA: 00:00:00 \r\e[0m"
        end
      end
    end
  end

  context 'when it is started' do
    before { formatter.start(2) }

    it 'sets the total to the number of examples' do
      expect(formatter.progress.total).to eql 2
    end

    context 'and an example passes' do
      before do
        output.rewind

        formatter.example_passed(example)
      end

      it 'outputs the proper bar information' do
        expect(fuubar_results).to start_with "\e[32m 1/2 |== 50 ==>        |  ETA: 00:00:00 \r\e[0m"
      end
    end

    context 'and an example pends' do
      before do
        output.rewind

        formatter.example_pending(example)
      end

      it 'outputs the proper bar information' do
        expect(fuubar_results).to start_with "\e[33m 1/2 |== 50 ==>        |  ETA: 00:00:00 \r\e[0m"
      end

      context 'and then an example succeeds' do
        before do
          output.rewind

          formatter.example_pending(example)
        end

        it 'outputs the pending bar' do
          expect(fuubar_results).to start_with "\e[33m 2/2 |===== 100 ======>| Time: 00:00:00 \n\e[0m"
        end
      end
    end

    context 'and an example fails' do
      it 'outputs the proper bar information' do
        output.rewind

        formatter.example_failed(failed_example)

        expect(fuubar_results).to end_with "\e[31m 1/2 |== 50 ==>        |  ETA: 00:00:00 \r\e[0m"
      end

      it 'dumps the failure' do
        allow(formatter).to receive(:dump_failure).
                            and_return('dump failure')

        allow(formatter).to receive(:dump_backtrace).
                            and_return('dump backtrace')

        formatter.example_failed(failed_example)

        expect(formatter).to have_received(:dump_failure).
                             with(failed_example, 0)

        expect(formatter).to have_received(:dump_backtrace).
                             with(failed_example)
      end

      context 'and then an example succeeds' do
        before do
          formatter.example_failed(failed_example)

          output.rewind

          formatter.example_passed(example)
        end

        it 'outputs the failed bar' do
          expect(fuubar_results).to start_with "\e[31m 2/2 |===== 100 ======>| Time: 00:00:00 \n\e[0m"
        end
      end

      context 'and then an example pends' do
        before do
          formatter.example_failed(failed_example)

          output.rewind

          formatter.example_pending(example)
        end

        it 'outputs the failed bar' do
          expect(fuubar_results).to start_with "\e[31m 2/2 |===== 100 ======>| Time: 00:00:00 \n\e[0m"
        end
      end
    end

    it 'can properly log messages' do
      formatter.message 'My Message'

      expect(fuubar_results).to end_with "My Message\n 0/2 |>                |  ETA: ??:??:?? \r"
    end
  end
end
