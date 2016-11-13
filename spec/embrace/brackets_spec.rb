require "spec_helper"

RSpec.describe Embrace::Brackets do
  matcher :have_brackets do |opening, closing|
    match do |actual|
      actual.call("text") == "#{opening}text#{closing}"
    end
  end

  describe ".new" do
    it "returns a brackets closure for the given brackets" do
      expect(described_class.from_brackets("(", ")")).to have_brackets "(", ")"
    end
  end

  describe ".from_str" do
    it "returns a brackets closure for the given style" do
      expect(described_class.from_str("()")).to have_brackets "(", ")"
    end

    context "given a style with an odd length" do
      it "the extra character goes in the closing bracket" do
        expect(described_class.from_str("<b></b>")).to have_brackets "<b>", "</b>"
      end
    end

    context "given an empty style" do
      it "returns empty opening and closing brackets" do
        expect(described_class.from_str("")).to have_brackets "", ""
      end
    end
  end

  describe "method" do
    context "given a style string" do
      it "returns a brackets closure for the given style" do
        expect(Embrace::Brackets("()")).to have_brackets "(", ")"
      end
    end

    context "given opening and closing brackets" do
      it "returns a brackets closure using the given parameters" do
        expect(Embrace::Brackets("(", ")")).to have_brackets "(", ")"
      end
    end

    context "given an array" do
      it "returns the array as a brackets closure" do
        expect(Embrace::Brackets([ "[", "]" ])).to have_brackets "[", "]"
      end
    end

    context "given a brackets closure" do
      it "returns the closure" do
        brackets = described_class.from_str("[]")
        expect(Embrace::Brackets(brackets)).to be brackets
      end
    end

    context "given some other type of value" do
      it "converts the value to a string and returns the brackets closure for that style" do
        style = double(:style)
        expect(style).to receive(:to_s).and_return "<>"
        expect(Embrace::Brackets(style)).to have_brackets "<", ">"
      end
    end
  end
end
