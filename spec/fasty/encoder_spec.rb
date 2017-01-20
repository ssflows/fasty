require "spec_helper"

RSpec.describe Encoder do
  describe "execute" do
    it "initializes with correct input" do
      enc = Encoder.new(Alignment.new(Helpers.fasta))
      expect(enc.dictionary).not_to be nil
      expect(enc.encoded_alignment).not_to be nil
    end
  end
end
