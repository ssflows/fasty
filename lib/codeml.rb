require_relative "codeml/preparer"
require_relative "codeml/runner"
require_relative "codeml/outputter"
require_relative "codeml/codeml_result"

class Codeml
  PROGRAM = "PAML-codeml".freeze
  EXECUTABLE = "cdmw.py".freeze
  INPUT_ALIGNMENT = "aligned.phylip".freeze
  INPUT_TREE = "tree.nwk".freeze
  OUTPUT = "output.mlc".freeze

  attr_reader :vault, :args

  def initialize(workdir)
    @vault = Vault.new("codeml", workdir)
    @report = ToolReport.new(program: PROGRAM, exec: EXECUTABLE, start: Time.now)
  end

  def execute(args)
    @input = args.fetch(:input)
    Preparer.new({vault: @vault, input: @input}).execute
    Runner.new({vault: @vault, report: @report}).execute
    Outputter.new({vault: @vault, report: @report}).execute
  end
end
