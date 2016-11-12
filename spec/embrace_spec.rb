require "spec_helper"

describe Embrace do
  it "has a version number" do
    expect(Embrace::VERSION).not_to be nil
  end

  describe ".wrap" do
    it "wraps the text in the 'before' and 'after' parameters" do
      expect(described_class.wrap("text", "[", "]") ).to eq "[text]"
    end
  end

  describe ".wrapper" do
    it "returns a proc that wraps text in the 'before' and 'after' parameters" do
      wrapper = described_class.wrapper("<", ">")
      expect(wrapper.call("text")).to eq "<text>"
    end
  end

  describe ".bracket" do
    it "brackets the text using the given style" do
      expect(Embrace::Brackets).to receive(:split).with("{{}}").and_call_original
      expect(described_class.bracket("text", style: "{{}}")).to eq "{{text}}"
    end
  end

  describe ".bracketer" do
    it "returns a proc that brackets text in the given style" do
      bracketer = described_class.bracketer(style: "{}")
      expect(bracketer["text"]).to eq "{text}"
    end
  end
end
