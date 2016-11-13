require "embrace"

module Embrace
  class Brackets < Proc
    class << self
      def new(opening, closing)
        super(&(->(text) { "#{opening}#{text}#{closing}" }))
      end

      def from_str(style)
        i = style.size / 2
        new(style[0...i], style[i..-1])
      end
    end

    def to_ary
      bracketed = self["a"]
      index = bracketed.chars.zip(self["b"].chars).find_index { |a, b| a != b }
      [ bracketed[0...index], bracketed[(index + 1)..-1] ]
    end

    alias_method :to_a, :to_ary

    def inspect
      "#<Brackets style=#{to_a.join('').inspect}>"
    end
  end

  module_function

  def Brackets(style_or_opening, *closing)
    return Brackets.new(style_or_opening, *closing) unless closing.empty?

    case style_or_opening
    when Brackets then style_or_opening
    when Array    then Brackets.new(*style_or_opening)
    else
      Brackets.from_str(style_or_opening.to_s)
    end
  end
end
