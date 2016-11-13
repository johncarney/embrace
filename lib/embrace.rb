require "embrace/version"
require "embrace/brackets"
require "embrace/string_methods"

module Embrace
  BRACKETS    = Brackets.new("[", "]").freeze
  PARENTHESES = Brackets.new("(", ")").freeze
  BRACES      = Brackets.new("{", "}").freeze

  refine String do
    include StringMethods
  end

  module_function

  def bracket(text, style:, pattern: /\A.*\z/)
    text.gsub(pattern, &Brackets(style).method(:around))
  end

  def bracketer(style:, **options)
    brackets = Brackets(style)
    ->(text) { bracket(text, style: brackets, **options)}
  end
end
