require 'spec_helper'
require 'stringio'

describe Fuubar do
  let(:output) { StringIO.new }

  let(:formatter) do
    formatter = Fuubar.new(output)
    formatter.start(2)

    formatter
  end

  let(:progress_bar) { formatter.instance_variable_get(:@progress_bar) }
  let(:example) { RSpec::Core::ExampleGroup.describe.example }


  describe 'start' do

    it 'should create a new ProgressBar' do
      progress_bar.should be_instance_of ProgressBar::Base
    end

    it 'should set the format of the bar' do
      progress_bar.instance_variable_get(:@format_string).should == ' %c/%C |%w>%i| %e '
    end

    it 'should set the total amount of specs' do
      progress_bar.total.should == 2
    end

    it 'should set the output' do
      progress_bar.send(:output).should == formatter.output
    end

    it 'should set the example_count' do
      formatter.instance_variable_get(:@example_count).should == 2
    end

    it 'should set the bar mark to =' do
      progress_bar.instance_variable_get(:@bar).progress_mark.should == '='
    end

  end

  describe 'passed, pending and failed' do

    before do
      formatter.stub!(:increment)
    end

    describe 'example_passed' do

      it 'should call the increment method' do
        formatter.should_receive :increment
        formatter.example_passed(example)
      end

    end

    describe 'example_pending' do

      it 'should call the increment method' do
        formatter.should_receive :increment
        formatter.example_pending(example)
      end

      it 'should set the state to :yellow' do
        formatter.example_pending(example)
        formatter.state.should == :yellow
      end

      it 'should not set the state to :yellow when it is :red already' do
        formatter.instance_variable_set(:@state, :red)
        formatter.example_pending(example)
        formatter.state.should == :red
      end

    end

    describe 'example_failed' do

      before do
        formatter.instafail.stub!(:example_failed)
      end

      it 'should call the increment method' do
        formatter.should_receive :increment
        formatter.example_failed(example)
      end

      it 'should call instafail.example_failed' do
        formatter.instafail.should_receive(:example_failed).with(example)
        formatter.example_failed(example)
      end

      it 'should set the state to :red' do
        formatter.example_failed(example)
        formatter.state.should == :red
      end

    end

  end

  describe 'increment' do

    it 'should increment the progress bar' do
      progress_bar.should_receive(:increment)
      formatter.increment
    end

  end

  describe 'instafail' do

    it 'should be an instance of RSpec::Instafail' do
      formatter.instafail.should be_instance_of(RSpec::Instafail)
    end

  end

  describe 'state' do

    it 'should be :green by default' do
      formatter.state.should == :green
    end

  end

end
