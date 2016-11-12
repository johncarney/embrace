require "embrace/version"
require "embrace/brackets"
require "embrace/string_methods"

module Embrace
  refine String do
    include StringMethods
  end

  module_function

  def wrap(text, before, after)
    "#{before}#{text}#{after}"
  end

  def wrapper(*with)
    ->(text) { wrap(text, *with) }
  end

  def bracket(text, style:)
    wrap(text, *Brackets(style))
  end

  def bracketer(style:)
    wrapper(*Brackets(style))
  end
end
