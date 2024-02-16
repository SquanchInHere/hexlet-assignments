# frozen_string_literal: true
require_relative 'test_helper'
require_relative '../lib/stack'

class StackTest < Minitest::Test
  def setup
    @stack = Stack.new
  end

  def test_push
    @stack.push!'Ruby'
    @stack.push!'PHP'
    @stack.push!'Python'
    assert @stack.size == 3
  end

  def test_pop
    @stack.push!'Ruby'
    @stack.push!'PHP'
    @stack.push!'Python'
    @stack.pop!
    assert @stack.size == 2
  end

  def test_clear
    @stack.push!'Ruby'
    @stack.push!'PHP'
    @stack.push!'Python'
    @stack.clear!
    assert @stack.empty?
  end

  def test_empty
    assert @stack.empty?
  end

end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?
