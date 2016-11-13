require "spec_helper"

RSpec.describe Embrace::StringMethods do
  let(:the_string) { "string".extend described_class }

  describe "#wrap" do
    it "wraps the string in the given parameters" do
      expect(the_string.wrap(">", "<")).to eq ">string<"
    end

    context "given a pattern" do
      it "wraps the matching parts of the string in the given parameters" do
        expect(the_string.wrap("(", ")", pattern: /[it]/)).to eq "s(t)r(i)ng"
      end
    end
  end

  describe "#bracket" do
    it "puts square brackets around the string" do
      expect(the_string.bracket).to eq "[string]"
    end

    context "given a bracket style" do
      it "uses the given style" do
        expect(the_string.bracket(style: "<>")).to eq "<string>"
      end
    end

    context "given a pattern" do
      it "brackets the matching parts of the string" do
        expect(the_string.bracket(pattern: /[it]/)).to eq "s[t]r[i]ng"
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

    context "given a pattern" do
      it "parenthesizes the matching parts of the string" do
        expect(the_string.parenthesize(pattern: /[it]/)).to eq "s(t)r(i)ng"
      end
    end
  end

  describe "#brace" do
    it "puts braces around the string" do
      expect(the_string.brace).to eq "{string}"
    end

    context "given a bracket style" do
      it "uses the given style" do
        expect(the_string.brace(style: "<()>")).to eq "<(string)>"
      end
    end

    context "given a pattern" do
      it "puts braces around the matching parts of the string" do
        expect(the_string.brace(pattern: /[it]/)).to eq "s{t}r{i}ng"
      end
    end
  end
end
