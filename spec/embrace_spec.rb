require "spec_helper"

describe Embrace do
  it "has a version number" do
    expect(Embrace::VERSION).not_to be nil
  end

  describe ".wrap" do
    it "wraps the text in the 'before' and 'after' parameters" do
      expect(described_class.wrap("text", "[", "]") ).to eq "[text]"
    end

    context "given nil for text" do
      it { expect(described_class.wrap(nil, "[", "]")).to be_nil }
    end
  end

  describe ".wrapper" do
    it "returns a proc that wraps text in the 'before' and 'after' parameters" do
      wrapper = described_class.wrapper("<", ">")
      expected_result = Object.new

      expect(described_class).to receive(:wrap).with("text", "<", ">").and_return(expected_result)
      expect(wrapper.call("text")).to eq expected_result
    end
  end
end
