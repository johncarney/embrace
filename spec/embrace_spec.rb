require "spec_helper"

RSpec.describe Embrace do
  it "has a version number" do
    expect(Embrace::VERSION).not_to be nil
  end

  describe ".wrap" do
    it "wraps the text in the given parameters" do
      expect(described_class.wrap("text", "[", "]") ).to eq "[text]"
    end

    context "given a pattern" do
      it "wraps the matching parts of the text in the given parameters" do
        text = "the quick brown fox"
        pattern = /quick|fox/
        expect(described_class.wrap(text, ":", ":", pattern: pattern)).to eq "the :quick: brown :fox:"
      end
    end
  end

  describe ".wrapper" do
    it "returns a proc that wraps text in the given parameters" do
      wrapper = described_class.wrapper("<", ">")
      expect(wrapper.call("text")).to eq "<text>"
    end

    context "given a pattern" do
      it "returns a proc that raps the matching parts of the text in the given parameters" do
        wrapper = described_class.wrapper("<", ">", pattern: "text")
        expect(wrapper.call("some text.")).to eq "some <text>."
      end
    end
  end

  describe ".bracket" do
    it "brackets the text using the given style" do
      expect(Embrace::Brackets).to receive(:split).with("{{}}").and_call_original
      expect(described_class.bracket("text", style: "{{}}")).to eq "{{text}}"
    end

    context "given a pattern" do
      it "brackets the matching parts of the text in the given style" do
        expect(Embrace::Brackets).to receive(:split).with("[]").and_call_original
        expect(described_class.bracket("some text.", style: "[]", pattern: "text")).to eq "some [text]."
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
