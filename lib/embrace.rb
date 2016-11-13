require "embrace/version"
require "embrace/brackets"
require "embrace/string_methods"

module Embrace
  refine String do
    include StringMethods
  end

  module_function

  def wrap(text, before, after, pattern: /\A.*\z/)
    text.gsub(pattern, "#{before}\\0#{after}")
  end

  def wrapper(*with, **options)
    ->(text) { wrap(text, *with, **options) }
  end

  def bracket(text, style:, **options)
    wrap(text, *Brackets(style), **options)
  end

  def bracketer(style:, **options)
    wrapper(*Brackets(style), **options)
  end
end
