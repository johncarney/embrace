require "embrace/version"
require "embrace/brackets"
require "embrace/string_methods"

module Embrace
  using Brackets

  refine String do
    include StringMethods
  end

  module_function

  # wrap

  def wrap(text, before, after)
    "#{before}#{text}#{after}"
  end

  def wrap_if(text, *with, &test)
    return text unless test.yield text

    wrap(text, *with)
  end

  def wrap_unless(text, *with, &test)
    return text if test.yield text

    wrap(text, *with)
  end

  # wrapper

  def wrapper(*with)
    ->(text) { wrap(text, *with) }
  end

  def if_wrapper(*with, &test)
    ->(text) { wrap_if(text, *with, &test) }
  end

  def unless_wrapper(*with, &test)
    ->(text) { wrap_unless(text, *with, &test) }
  end

  # bracket

  def bracket(text, style:)
    wrap(text, *Brackets(style))
  end

  def bracket_if(text, style:, &test)
    wrap_if(text, *Brackets(style), &test)
  end

  def bracket_unless(text, style:, &test)
    wrap_unless(text, *Brackets(style), &test)
  end

  # bracketer

  def bracketer(style:)
    wrapper(*Brackets(style))
  end

  def if_bracketer(style:, &test)
    if_wrapper(*Brackets(style), &test)
  end

  def unless_bracketer(style:, &test)
    unless_wrapper(*Brackets(style), &test)
  end
end
