require "embrace"

module Embrace
  class Brackets < Proc
    class << self
      def from_brackets(opening, closing)
        new do |text|
          "#{opening}#{text}#{closing}"
        end
      end

      def from_str(style)
        i = style.size / 2
        from_brackets(style[0...i], style[i..-1])
      end
    end

    def to_ary
      bracketed = self["a"]
      index = bracketed.chars.zip(self["b"].chars).find_index { |a, b| a != b }
      [ bracketed[0...index], bracketed[(index + 1)..-1] ]
    end

    alias_method :to_a, :to_ary

    def inspect
      to_a.inspect
    end
  end

  module_function

  def Brackets(style, *rest)
    return Brackets.from_brackets(*[ style, *rest ].map(&:to_s)) unless rest.empty?

    case style
    when Brackets then style
    when Array    then Brackets(*style)
    else
      Brackets.from_str(style.to_s)
    end
  end
end
