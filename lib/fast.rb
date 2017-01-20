require_relative "fast/preparer"
require_relative "fast/runner"
require_relative "fast/outputter"

class Fast
  PROGRAM   = "fastcodeml".freeze
  EXECUTABLE = "fast".freeze
  INPUT_ALIGNMENT = "aligned.phy".freeze
  INPUT_TREE      = "tree.nwk".freeze
  OUTPUT    = "output.out".freeze

  attr_reader :vault, :args

  def initialize(workdir)
    @vault = Vault.new("fast", workdir)
    @report = ToolReport.new(program: PROGRAM, exec: EXECUTABLE, start: Time.now)
  end

  def execute(args)
    @input = args.fetch(:input)
    Preparer.new({vault: @vault, input: @input}).execute
    Runner.new({vault: @vault, report: @report}).execute
    Outputter.new({vault: @vault, report: @report}).execute
  end
end
