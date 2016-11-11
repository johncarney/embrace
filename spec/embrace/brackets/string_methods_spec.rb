require "spec_helper"

describe Embrace::Brackets::StringMethods do
  let(:the_string) { "string".extend described_class }

  describe "#bracket" do
    it "wraps the string in the given bracket style" do
      expected_result = Object.new
      expect(Embrace::Brackets).to receive(:wrap).with("string", "{").and_return expected_result
      expect(the_string.bracket("{")).to eq expected_result
    end
  end
end
