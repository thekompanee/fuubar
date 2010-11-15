require 'spec_helper'

describe Fuubar do
  before do
    @output = StringIO.new
    @formatter = Fuubar.new(@output)
    @formatter.start(2)
    @progress_bar = @formatter.instance_variable_get(:@progress_bar)
    @example = RSpec::Core::ExampleGroup.describe.example
  end

  describe 'start' do

    it 'should create a new ProgressBar' do
      @progress_bar.should be_instance_of ProgressBar
    end

    it 'should set the title' do
      @progress_bar.instance_variable_get(:@title).should == '2 examples'
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
  end
end
