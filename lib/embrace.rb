require "embrace/version"
require "embrace/brackets"
require "embrace/string_methods"

module Embrace
  BRACKETS    = Brackets("[", "]").freeze
  PARENTHESES = Brackets("(", ")").freeze
  BRACES      = Brackets("{", "}").freeze

  SINGLE_QUOTES = Brackets("'", "'").freeze
  DOUBLE_QUOTES = Brackets('"', '"').freeze

  refine String do
    include StringMethods
  end

  module_function

  def bracket(text, style:, pattern: /\A.*\z/)
    text.gsub(pattern, &Brackets(style))
  end

  def bracketer(style:, **options)
    brackets = Brackets(style)
    ->(text) { bracket(text, style: brackets, **options)}
  end
end
