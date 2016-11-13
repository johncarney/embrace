module Embrace
  module StringMethods
    def bracket(style: BRACKETS, **options)
      Embrace.bracket(self, style: style, **options)
    end

    def parenthesize(style: PARENTHESES, **options)
      Embrace.bracket(self, style: style, **options)
    end

    def brace(style: BRACES, **options)
      Embrace.bracket(self, style: style, **options)
    end
  end
end
