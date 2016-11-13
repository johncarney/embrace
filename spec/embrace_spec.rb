require "spec_helper"

RSpec.describe Embrace do
  it "has a version number" do
    expect(Embrace::VERSION).not_to be nil
  end

  describe ".bracket" do
    it "brackets the text using the given style" do
      expect(described_class.bracket("text", style: "{{}}")).to eq "{{text}}"
    end

    context "given an array for style" do
      it "brackets the text using the array elements" do
        expect(described_class.bracket("text", style: %w{ start> <finish })).to eq "start>text<finish"
      end
    end

    context "given a pattern" do
      it "brackets the matching parts of the text in the given style" do
        text = "the quick brown fox"
        pattern = /quick|fox/
        expect(described_class.bracket(text, style: "::", pattern: pattern)).to eq "the :quick: brown :fox:"
      end
    end
  end

  describe ".bracketer" do
    it "returns a proc that brackets text in the given style" do
      bracketer = described_class.bracketer(style: "{}")
      expect(bracketer["text"]).to eq "{text}"
    end

    context "given a pattern" do
      it "returns a proc that brackets the matching parts of the text in the given style" do
        bracketer = described_class.bracketer(style: "{}", pattern: "text")
        expect(bracketer["some text."]).to eq "some {text}."
      end
    end
  end
end
