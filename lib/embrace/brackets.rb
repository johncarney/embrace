require "embrace"

module Embrace
  class Brackets
    attr_reader :opening, :closing

    def initialize(opening, closing)
      @opening = opening
      @closing = closing
    end

    def around(text)
      "#{opening}#{text}#{closing}"
    end

    def to_ary
      [ opening, closing ]
    end

    alias_method :to_a, :to_ary

    def to_s
      "#{opening}#{closing}"
    end

    def self.from_str(style)
      i = style.size / 2
      new(style[0...i], style[i..-1])
    end
  end

  module_function

  def Brackets(style)
    case style
    when Brackets then style
    when Array    then Brackets.new(*style)
    else
      Brackets.from_str(style.to_s)
    end
  end
end
