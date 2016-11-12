require "spec_helper"

describe Embrace::Brackets do
  describe ".split" do
    it "returns the opening and closing strings for the given style" do
      expect(described_class.split("()")).to eq [ "(", ")" ]
    end

    context "given a style with an odd length" do
      it "ignores the middle character" do
        expect(described_class.split("<<.>>")).to eq [ "<<", ">>" ]
      end
    end

    context "given an empty style" do
      it "returns empty strings" do
        expect(described_class.split("")).to eq [ "", "" ]
      end
    end

    context "given an single-character style" do
      it "returns empty strings" do
        expect(described_class.split("-")).to eq [ "", "" ]
      end
    end
  end

  describe "method" do
    context "given a string" do
      it "returns the opening and closing strings for the given style" do
        expect(described_class).to receive(:split).with("()").and_call_original
        expect(Embrace::Brackets("()")).to eq [ "(", ")" ]
      end
    end

    context "given an array" do
      it "returns the array" do
        expect(Embrace::Brackets([ "[", "]" ])).to eq [ "[", "]" ]
      end
    end

    context "given some other type of value" do
      it "converts the value to a string and returns the brackets for that style" do
        style = double(:style)
        expect(style).to receive(:to_s).and_return "<>"
        expect(Embrace::Brackets(style)).to eq [ "<", ">" ]
      end
    end
  end
end
