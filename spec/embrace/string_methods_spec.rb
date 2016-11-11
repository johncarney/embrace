require "spec_helper"

describe Embrace::StringMethods do
  let(:the_string) { "string".extend described_class }

  describe "#embrace" do
    it "wraps the string in the given parameters" do
      expect(the_string.embrace(">", "<")).to eq ">string<"
    end
  end
end
