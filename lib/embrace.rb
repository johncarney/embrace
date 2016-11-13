require "embrace/version"
require "embrace/brackets"
require "embrace/string_methods"

module Embrace
  refine String do
    include StringMethods
  end

  module_function

  def bracket(text, style:, pattern: /\A.*\z/)
    opening, closing = Brackets(style)
    text.gsub(pattern, "#{opening}\\0#{closing}")
  end

  def bracketer(style:, **options)
    brackets = Brackets(style)
    ->(text) { bracket(text, style: brackets, **options)}
  end
end
