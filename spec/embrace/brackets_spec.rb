require "spec_helper"

describe Embrace::Brackets do
  describe ".wrap" do
    { "(" => ")", "{" => "}", "[" => "]", "<" => ">" }.each do |open, close|
      context "given '#{open}' for 'style'" do
        it "wraps the text in '#{open}#{close}'" do
          expect(described_class.wrap("text", open)).to eq "#{open}text#{close}"
        end
      end
    end

    context "given an unrecognized bracket style" do
      it "adds the 'style' parameter to the beginning and ending of the text" do
        expect(described_class.wrap("text", "*")).to eq "*text*"
      end
    end

    context "with no 'style' parameter" do
      it "wraps the text in '()'" do
        expect(described_class.wrap("text")).to eq "(text)"
      end
    end

    context "given nil for text" do
      it { expect(described_class.wrap(nil)).to be_nil }
    end
  end

  describe ".wrapper" do
    it "returns a proc that wraps text in the given bracket style" do
      wrapper = described_class.wrapper("[")
      expected_result = Object.new

      expect(described_class).to receive(:wrap).with("text", "[").and_return(expected_result)
      expect(wrapper.call("text")).to eq expected_result
    end
  end
end
