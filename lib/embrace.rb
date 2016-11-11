require "embrace/version"
require "embrace/brackets"

module Embrace
  module StringMethods
    def embrace(*with)
      Embrace.wrap(self, *with)
    end
  end

  refine String do
    include StringMethods
  end

  module_function

  def wrap(text, before, after)
    return unless text

    "#{before}#{text}#{after}"
  end

  def wrapper(*with)
    ->(text) { wrap(text, *with) }
  end
end
