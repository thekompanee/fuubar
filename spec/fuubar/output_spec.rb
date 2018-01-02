# frozen_string_literal: true

require 'fuubar'

class TestNonTtyOutputClass
  def tty?
    false
  end
end

class TestTtyOutputClass
  def hello
    'hello'
  end

  def tty?
    true
  end
end

class    Fuubar < RSpec::Core::Formatters::BaseTextFormatter
describe Output do
  it 'delegates anything to the passed in object' do
    output = Output.new(TestTtyOutputClass.new)

    expect(output.hello).to eql 'hello'
    expect(output).to       be_tty
  end

  it 'can override the TTY of the passed in class' do
    output = Output.new(TestNonTtyOutputClass.new, true)

    expect(output).to be_tty
  end
end
end
