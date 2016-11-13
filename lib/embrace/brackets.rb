require "embrace"

module Embrace
  module Brackets
    module_function

    def split(style)
      i = style.size / 2
      [ style[0...i], style[i..-1] ]
    end
  end

  module_function

  def Brackets(style)
    return style.to_ary if style.respond_to? :to_ary

    Brackets.split(style.to_s)
  end
end
