require 'fuubar'
require 'stringio'
require 'ostruct'

# rubocop:disable Metrics/LineLength
describe Fuubar do
  let(:output) do
    io = StringIO.new

    allow(io).to  receive(:tty?).
                  and_return(true)

    io
  end

  let(:formatter)            { Fuubar.new(output) }
  let(:example)              { RSpec::Core::ExampleGroup.describe.example }
  let(:example_count)        { 2 }
  let(:start_notification)   { RSpec::Core::Notifications::StartNotification.new(example_count, Time.now) }
  let(:message_notification) { RSpec::Core::Notifications::MessageNotification.new('My Message') }
  let(:example_notification) { RSpec::Core::Notifications::ExampleNotification.for(example) }
  let(:pending_notification) { RSpec::Core::Notifications::ExampleNotification.for(pending_example) }
  let(:failed_notification)  { RSpec::Core::Notifications::ExampleNotification.for(failed_example) }

  let(:failed_example) do
    exception = RuntimeError.new('Test Fuubar Error')
    exception.set_backtrace [
                              "/my/filename.rb:4:in `some_method'",
                            ]

    example = RSpec::Core::ExampleGroup.describe.example

    example.metadata[:file_path] = '/my/example/spec.rb'
    example.metadata[:execution_result].status = :failed
    example.metadata[:execution_result].exception = exception

    example
  end

  let(:pending_example) do
    example = RSpec::Core::ExampleGroup.describe.example
    example.metadata[:execution_result].pending_fixed = true
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

      formatter.start(start_notification)

      expect(formatter.progress).to be_started
    end

    it 'creates a new ProgressBar' do
      expect(formatter.progress).to be_instance_of ProgressBar::Base
    end

    it 'sets the format of the bar to the default' do
      expect(formatter.progress.instance_variable_get(:@format)).to eql ' %c/%C |%w>%i| %e '
    end

    it 'sets the total to the number of examples' do
      expect(formatter.progress.total).to be_zero
    end

    it 'sets the bar\'s output' do
      expect(formatter.progress.send(:output).stream).to            be_a Fuubar::Output
      expect(formatter.progress.send(:output).stream.__getobj__).to eql output
    end

    context 'and continuous integration is enabled' do
      before do
        RSpec.configuration.fuubar_progress_bar_options = { :length => 40 }
        ENV['CONTINUOUS_INTEGRATION'] = 'true'
      end

      it 'throttles the progress bar at one second' do
        throttle      = formatter.progress.__send__(:output).__send__(:throttle)
        throttle_rate = throttle.__send__(:rate)

        expect(throttle_rate).to eql 1.0
      end

      context 'when processing an example' do
        before do
          formatter.start(start_notification)

          throttle       = formatter.progress.__send__(:output).__send__(:throttle)
          _throttle_rate = throttle.__send__(:rate=, 0.0)

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
        RSpec.configuration.fuubar_progress_bar_options = { :length => 40 }
        ENV['CONTINUOUS_INTEGRATION'] = 'false'
      end

      it 'throttles the progress bar at the default rate' do
        throttle      = formatter.progress.__send__(:output).__send__(:throttle)
        throttle_rate = throttle.__send__(:rate)

        expect(throttle_rate).to eql 0.01
      end

      context 'when processing an example' do
        before do
          formatter.start(start_notification)

          throttle       = formatter.progress.__send__(:output).__send__(:throttle)
          _throttle_rate = throttle.__send__(:rate=, 0.0)

          output.rewind

          formatter.example_passed(example)
        end

        it 'does not output color codes' do
          expect(fuubar_results).to start_with "\e[32m 1/2 |== 50 ==>        |  ETA: 00:00:00 \r\e[0m"
        end
      end
    end
  end

  context 'when custom options are set after the formatter is created' do
    before(:each) do
      formatter
      RSpec.configuration.fuubar_progress_bar_options = {
        :length        => 40,
        :throttle_rate => 0.0,
        :format        => '%c',
      }
    end

    context 'when the bar is started' do
      before(:each) { formatter.start(start_notification) }

      it 'properly creates the bar' do
        expect(formatter.progress.instance_variable_get(:@format)).to eql '%c'
      end
    end
  end

  context 'when it is started' do
    before { formatter.start(start_notification) }

    it 'sets the total to the number of examples' do
      expect(formatter.progress.total).to eql 2
    end

    context 'and no custom options are passed in' do
      it 'sets the format of the bar to the default' do
        expect(formatter.progress.instance_variable_get(:@format)).to eql ' %c/%C |%w>%i| %e '
      end
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

        formatter.example_pending(pending_example)
      end

      it 'outputs the proper bar information' do
        formatter.progress.increment
        expect(fuubar_results).to start_with "\e[33m 1/2 |== 50 ==>        |  ETA: 00:00:00 \r\e[0m"
      end

      context 'and then an example succeeds' do
        before do
          output.rewind

          formatter.example_pending(pending_notification)
        end

        it 'outputs the pending bar' do
          expect(fuubar_results).to start_with "\e[33m 2/2 |===== 100 ======>| Time: 00:00:00 \n\e[0m"
        end
      end
    end

    context 'and an example fails' do
      it 'outputs the proper bar information' do
        output.rewind

        formatter.example_failed(failed_notification)

        expect(fuubar_results).to end_with "\e[31m 1/2 |== 50 ==>        |  ETA: 00:00:00 \r\e[0m"
      end

      context 'and then an example succeeds' do
        before do
          formatter.example_failed(failed_notification)

          output.rewind

          formatter.example_passed(example)
        end

        it 'outputs the failed bar' do
          expect(fuubar_results).to start_with "\e[31m 2/2 |===== 100 ======>| Time: 00:00:00 \n\e[0m"
        end
      end

      context 'and then an example pends' do
        before do
          formatter.example_failed(failed_notification)

          output.rewind

          formatter.example_pending(example_notification)
        end

        it 'outputs the failed bar' do
          expect(fuubar_results).to start_with "\e[31m 2/2 |===== 100 ======>| Time: 00:00:00 \n\e[0m"
        end
      end
    end

    it 'can properly log messages' do
      formatter.message message_notification

      expect(fuubar_results).to end_with "My Message\n 0/2 |>                |  ETA: ??:??:?? \r"
    end
  end
end
