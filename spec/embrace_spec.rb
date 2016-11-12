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

  describe ".wrap_if" do
    subject { described_class.wrap_if("text", "/", "/", &block) }

    context "when the given block yields true for the text" do
      let(:block) { ->(_text) { true } }

      it "wraps the text" do
        expect(described_class).to receive(:wrap).with("text", "/", "/").and_call_original
        is_expected.to eq "/text/"
      end
    end

    context "when the given block yields false for the text" do
      let(:block) { ->(_text) { false } }

      it "returns the unwrapped text" do
        expect(described_class).to_not receive(:wrap).with("text", "-", "-")
        is_expected.to eq "text"
      end
    end
  end

  describe ".wrap_unless" do
    subject { described_class.wrap_unless("text", "/", "/", &block) }

    context "when the given block yields true for the text" do
      let(:block) { ->(_text) { true } }

      it "returns the unwrapped text" do
        expect(described_class).to_not receive(:wrap).with("text", "-", "-")
        is_expected.to eq "text"
      end
    end

    context "when the given block yields false for the text" do
      let(:block) { ->(_text) { false } }

      it "wraps the text" do
        expect(described_class).to receive(:wrap).with("text", "/", "/").and_call_original
        is_expected.to eq "/text/"
      end
    end
  end

  describe ".wrapper" do
    it "returns a proc that wraps text in the 'before' and 'after' parameters" do
      wrapper = described_class.wrapper("<", ">")
      expect(wrapper.call("text")).to eq "<text>"
    end
  end

  describe ".if_wrapper" do
    it "returns a proc that wraps text in the 'before' and 'after' parameters if the given block returns true for the text" do
      wrapper = described_class.if_wrapper("<", ">") { |text| !text.empty? }
      expect([ "text", "" ].map(&wrapper)).to eq [ "<text>", "" ]
    end
  end

  describe ".unless_wrapper" do
    it "returns a proc that wraps text in the 'before' and 'after' parameters if the given block returns true for the text" do
      wrapper = described_class.unless_wrapper("<", ">") { |text| text !~ /\S/ }
      expect([ "text", "  " ].map(&wrapper)).to eq [ "<text>", "  " ]
    end
  end

  describe ".bracket" do
    it "brackets the text using the given style" do
      expect(Embrace::Brackets).to receive(:split).with("{{}}").and_call_original
      expect(described_class.bracket("text", style: "{{}}")).to eq "{{text}}"
    end
  end

  describe ".bracket_if" do
    subject { described_class.bracket_if("text", style: "()", &block) }

    context "when the given block yields true for the text" do
      let(:block) { ->(_text) { true } }

      it "brackets the text" do
        expect(described_class).to receive(:wrap).with("text", "(", ")").and_call_original
        is_expected.to eq "(text)"
      end
    end

    context "when the given block yields false for the text" do
      let(:block) { ->(_text) { false } }

      it "returns the unbracketed text" do
        expect(described_class).to_not receive(:wrap).with("text", "[", "]")
        is_expected.to eq "text"
      end
    end
  end


  describe ".bracket_unless" do
    subject { described_class.bracket_unless("text", style: "()", &block) }

    context "when the given block yields true for the text" do
      let(:block) { ->(_text) { true } }

      it "returns the unbracketed text" do
        expect(described_class).to_not receive(:wrap).with("text", "(", ")")
        is_expected.to eq "text"
      end
    end

    context "when the given block yields false for the text" do
      let(:block) { ->(_text) { false } }

      it "brackets the text" do
        expect(described_class).to receive(:wrap).with("text", "(", ")").and_call_original
        is_expected.to eq "(text)"
      end
    end
  end

  describe ".bracketer" do
    it "returns a proc that brackets text in the given style" do
      bracketer = described_class.bracketer(style: "{}")
      expect(bracketer["text"]).to eq "{text}"
    end
  end

  describe ".if_bracketer" do
    it "returns a proc that brackets text in the given style if the given block returns true for the text" do
      bracketer = described_class.if_bracketer(style: "<>") { |text| !text.empty? }

      expect([ "text", "" ].map(&bracketer)).to eq [ "<text>", "" ]
    end
  end

  describe ".unless_bracketer" do
    it "returns a proc that brackets text in the given style if the given block returns false for the text" do
      bracketer = described_class.unless_bracketer(style: "<>") { |text| !text.empty? }

      expect([ "text", "" ].map(&bracketer)).to eq [ "text", "<>" ]
    end
  end
end
