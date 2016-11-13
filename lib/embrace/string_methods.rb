module Embrace
  module StringMethods
    def bracket(style: "[]", **options)
      Embrace.bracket(self, style: style, **options)
    end

    def parenthesize(style: "()", **options)
      Embrace.bracket(self, style: style, **options)
    end

    def brace(style: "{}", **options)
      Embrace.bracket(self, style: style, **options)
    end
  end
end
