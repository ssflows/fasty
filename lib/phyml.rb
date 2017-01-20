require_relative "phyml/preparer"
require_relative "phyml/runner"
require_relative "phyml/outputter"

class Phyml
  PROGRAM = "PhyML".freeze
  EXECUTABLE = "phyml".freeze
  INPUT = "aligned.phylip".freeze
  OUTPUT = "aligned.phylip_phyml_tree".freeze

  def initialize(workdir)
    @vault = Vault.new("phyml", workdir)
    @report = ToolReport.new(program: PROGRAM, exec: EXECUTABLE, start: Time.now)
  end

  def execute(args)
    @input = args.fetch(:input)
    Preparer.new({vault: @vault, input: @input}).execute
    Runner.new({vault: @vault, report: @report}).execute
    Outputter.new({vault: @vault, report: @report}).execute
  end

end
