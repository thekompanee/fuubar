require 'spec_helper'

describe Fuubar do

  before do
    @output = StringIO.new
    @options = Spec::Runner::Options.new(@output, @output)
    @formatter = Fuubar.new(@options, @output)
    @formatter.start(2)
    @progress_bar = @formatter.instance_variable_get(:@progress_bar)
    @example_group = Spec::Example::ExampleGroup.describe(nil)
    @formatter.example_group_started(@example_group)
    @example = @example = @example_group.example
  end

  describe 'start' do

    it 'should create a new ProgressBar' do
      @progress_bar.should be_instance_of ProgressBar
    end

    it 'should set the title' do
      @progress_bar.instance_variable_get(:@title).should == '  2 examples'
    end

    it 'should set the total amount of specs' do
      @progress_bar.instance_variable_get(:@total).should == 2
    end

    it 'should set the output' do
      @progress_bar.instance_variable_get(:@out).should == @formatter.output
    end

    it 'should set the example_count' do
      @formatter.instance_variable_get(:@example_count).should == 2
    end

    it 'should set the finished_count to 0' do
      @formatter.instance_variable_get(:@finished_count).should == 0
    end

    it 'should set the bar mark to =' do
      @progress_bar.instance_variable_get(:@bar_mark).should == '='
    end

  end

  describe 'passed, pending and failed' do

    before do
      @formatter.stub!(:increment)
    end

    describe 'example_passed' do

      it 'should call the increment method' do
        @formatter.should_receive :increment
        @formatter.example_passed(@example)
      end

    end

    describe 'example_pending' do

      it 'should call the increment method' do
        @formatter.should_receive :increment
        @formatter.example_pending(@example, 'message')
      end

      it 'should set the state to :yellow' do
        @formatter.example_pending(@example, 'message')
        @formatter.state.should == :yellow
      end

      it 'should not set the state to :yellow when it is :red already' do
        @formatter.instance_variable_set(:@state, :red)
        @formatter.example_pending(@example, 'message')
        @formatter.state.should == :red
      end

    end

    describe 'example_failed' do

      before do
        @formatter.instafail.stub!(:example_failed)
      end

      it 'should call the increment method' do
        @formatter.should_receive :increment
        @formatter.example_failed(@example, 1, 'message')
      end

      it 'should call instafail.example_failed' do
        @formatter.instafail.should_receive(:example_failed).with(@example, 1, 'message')
        @formatter.example_failed(@example, 1, 'message')
      end

      it 'should set the state to :red' do
        @formatter.example_failed(@example, 1, 'message')
        @formatter.state.should == :red
      end

    end

  end

  describe 'increment' do

    it 'should increment the progress bar' do
      @progress_bar.should_receive(:inc)
      @formatter.increment
    end

    it 'should change the progress bar title' do
      @formatter.stub!(:finished_count).and_return(1)
      @formatter.stub!(:example_count).and_return(2)
      @formatter.increment
      @progress_bar.instance_variable_get(:@title).should == '  1/2'
    end

    it 'should increment the finished_count' do
      lambda { @formatter.increment }.should change(@formatter, :finished_count).by(1)
    end

    it 'should increment the progress bar before updating the title' do
      @progress_bar.should_receive(:instance_variable_set).ordered
      @progress_bar.should_receive(:inc).ordered
      @formatter.increment
    end

  end

  describe 'instafail' do

    it 'should be an instance of RSpec::Instafail' do
      @formatter.instafail.should be_instance_of(RSpec::Instafail)
    end

    it 'should have same formatter options as fuubar' do
      @formatter.instafail.instance_variable_get(:@options).should == @options
    end
  end

  describe 'start_dump' do

    it 'should finish the progress bar' do
      @progress_bar.should_receive(:finish)
      @formatter.start_dump
    end

  end

  describe 'state' do

    it 'should be :green by default' do
      @formatter.state.should == :green
    end

  end

end
