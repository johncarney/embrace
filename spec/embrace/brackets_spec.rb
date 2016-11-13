require "spec_helper"

RSpec.describe Embrace::Brackets do
  matcher :have_brackets do |opening, closing|
    match do |actual|
      actual.opening == opening && actual.closing == closing
    end
  end

  it "can be implicity converted to an array" do
    expect(described_class.new("(", ")").to_ary).to eq [ "(", ")" ]
  end

  it "can be explicity converted to an array" do
    expect(described_class.new("(", ")").to_a).to eq [ "(", ")" ]
  end

  it "can be explicity converted to a string" do
    expect(described_class.new("(", ")").to_s).to eq "()"
  end

  describe "#to_proc" do
    it "returns a proc that wraps text" do
      expect(%w{ text }.map(&described_class.new("[", "]").to_proc)).to eq [ "[text]" ]
    end
  end

  describe "#around" do
    it "wraps the given text in the brackets" do
      expect(described_class.new("<", ">").around("some text")).to eq "<some text>"
    end
  end

  describe ".from_str" do
    it "returns brackets for the given style" do
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
    context "given a string" do
      it "returns brackets for the given style" do
        expect(described_class).to receive(:from_str).with("()").and_call_original
        expect(Embrace::Brackets("()")).to have_brackets "(", ")"
      end
    end

    context "given an array" do
      it "returns the array as brackets" do
        expect(Embrace::Brackets([ "[", "]" ])).to have_brackets "[", "]"
      end
    end

    context "given some other type of value" do
      it "converts the value to a string and returns the brackets for that style" do
        style = double(:style)
        expect(style).to receive(:to_s).and_return "<>"
        expect(Embrace::Brackets(style)).to have_brackets "<", ">"
      end
    end
  end
end
