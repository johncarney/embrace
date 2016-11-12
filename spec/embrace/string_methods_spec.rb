require "spec_helper"

describe Embrace::StringMethods do
  let(:the_string) { "string".extend described_class }

  describe "#wrap" do
    it "wraps the string in the given parameters" do
      expect(the_string.wrap(">", "<")).to eq ">string<"
    end
  end

  describe "#bracket" do
    it "puts brackets around the string" do
      expect(the_string.bracket).to eq "[string]"
    end

    context "given a bracket style" do
      it "uses the given style" do
        expect(the_string.bracket(style: "<>")).to eq "<string>"
      end
    end
  end

  describe "#parenthesize" do
    it "puts parentheses around the string" do
      expect(the_string.parenthesize).to eq "(string)"
    end

    context "given a bracket style" do
      it "uses the given style" do
        expect(the_string.parenthesize(style: "[]")).to eq "[string]"
      end
    end
  end

  describe "#brace" do
    it "puts braces around the string" do
      expect(the_string.brace).to eq "{string}"
    end

    context "given a bracket style" do
      it "uses the given style" do
        expect(the_string.brace(style: "<(.)>")).to eq "<(string)>"
      end
    end
  end
end
