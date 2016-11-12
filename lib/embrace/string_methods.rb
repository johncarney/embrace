module Embrace
  module StringMethods
    def wrap(*with)
      Embrace.wrap(self, *with)
    end

    def bracket(style: "[]")
      Embrace.bracket(self, style: style)
    end

    def parenthesize(style: "()")
      Embrace.bracket(self, style: style)
    end

    def brace(style: "{}")
      Embrace.bracket(self, style: style)
    end
  end
end
