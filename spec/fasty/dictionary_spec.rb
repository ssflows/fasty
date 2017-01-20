require "spec_helper"

RSpec.describe Dictionary do
  describe "execute" do
    it "initializes with correct input" do
      arr = ['asdflakjlkjlkj lkj ','asdfasd_lkjlkjasdf_lkjalksdf']
      dict = Dictionary.new(arr)
      expect(dict.get_by_key(arr.first.class)).to eq(String)
    end

    it "should fail if keys repeat"
    it "should should check for repeating codes"
  end
end
