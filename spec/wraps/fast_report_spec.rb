require "spec_helper"

RSpec.describe FastReport::Report do
  describe "init" do
    it "runs", focus: true do
      output = File.open("spec/fixtures/fast/valid_output/output.out").read
      stdout = File.open("spec/fixtures/fast/valid_output/stdout.out").read
      rep = FastReport::Report.new(output, stdout)
      expect(rep.sites).not_to be nil
      expect(rep.branches).not_to be nil
    end
  end
end
