require "embrace"

module Embrace
  module Brackets
    BRACKET_STYLES = Hash.new { |_, k| k }.merge({
      "(" => ")",
      "{" => "}",
      "[" => "]",
      "<" => ">"
    }).freeze

    module StringMethods
      def bracket(*style)
        Brackets.wrap(self, *style)
      end
    end

    refine String do
      include StringMethods
    end

    module_function

    def wrap(text, style = "(")
      Embrace.wrap(text, style, BRACKET_STYLES[style.to_s])
    end

    def wrapper(*style)
      ->(text) { wrap(text, *style) }
    end
  end
end
