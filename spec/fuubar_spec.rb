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
      expect(progress_bar).to be_instance_of ProgressBar::Base
    end

    it 'should set the format of the bar' do
      expect(progress_bar.instance_variable_get(:@format_string)).to eq ' %c/%C |%w>%i| %e '
    end

    it 'should set the total amount of specs' do
      expect(progress_bar.total).to eq 2
    end

    it 'should set the output' do
      expect(progress_bar.send(:output)).to eq formatter.output
    end

    it 'should set the bar mark to =' do
      expect(progress_bar.instance_variable_get(:@bar).progress_mark).to eq '='
    end

  end

  describe 'passed, pending and failed' do

    before do
      allow(formatter).to receive(:increment)
    end

    describe 'example_passed' do

      it 'should call the increment method' do
        expect(formatter).to receive :increment
        formatter.example_passed(example)
      end

    end

    describe 'example_pending' do

      it 'should call the increment method' do
        expect(formatter).to receive :increment
        formatter.example_pending(example)
      end

      it 'should set the state to :yellow' do
        formatter.example_pending(example)
        expect(formatter.state).to eq :yellow
      end

      it 'should not set the state to :yellow when it is :red already' do
        formatter.instance_variable_set(:@state, :red)
        formatter.example_pending(example)
        expect(formatter.state).to eq :red
      end

    end

    describe 'example_failed' do

      before do
        allow(formatter.instafail).to receive(:example_failed)
      end

      it 'should call the increment method' do
        expect(formatter).to receive :increment
        formatter.example_failed(example)
      end

      it 'should call instafail.example_failed' do
        expect(formatter.instafail).to receive(:example_failed).with(example)
        formatter.example_failed(example)
      end

      it 'should set the state to :red' do
        formatter.example_failed(example)
        expect(formatter.state).to eq :red
      end

    end

  end

  describe 'increment' do

    it 'should increment the progress bar' do
      expect(progress_bar).to receive(:increment)
      formatter.increment
    end

  end

  describe 'instafail' do

    it 'should be an instance of RSpec::Instafail' do
      expect(formatter.instafail).to be_instance_of(RSpec::Instafail)
    end

  end

  describe 'state' do

    it 'should be :green by default' do
      expect(formatter.state).to eq :green
    end

  end

end
