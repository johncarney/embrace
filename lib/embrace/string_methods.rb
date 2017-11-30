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

    def single_quote(style: SINGLE_QUOTES, **options)
      Embrace.bracket(self, style: style, **options)
    end

    def double_quote(style: DOUBLE_QUOTES, **options)
      Embrace.bracket(self, style: style, **options)
    end

    alias_method :quote, :double_quote
  end
end
