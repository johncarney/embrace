require "embrace"

module Embrace
  module Brackets
    module_function

    def from_brackets(opening, closing)
      ->(text) { "#{opening}#{text}#{closing}" }
    end

    def from_str(style)
      i = style.size / 2
      from_brackets(style[0...i], style[i..-1])
    end
  end

  module_function

  def Brackets(style_or_opening, *closing)
    return Brackets.from_brackets(style_or_opening, *closing) unless closing.empty?

    case style_or_opening
    when Proc  then style_or_opening
    when Array then Brackets.from_brackets(*style_or_opening)
    else
      Brackets.from_str(style_or_opening.to_s)
    end
  end
end
