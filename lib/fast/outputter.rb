require_relative "fast_report"

class Fast
  class Outputter

    # @param[args[:vault]] A Vault object
    # @param[args[:report]] A ToolReport object
    def initialize(args)
      @result = OpenStruct.new
      @vault = args.fetch(:vault)
      @report = args.fetch(:report)
    end

    def execute
      process_output if run_successful?
      @result
    end

    def process_output
      output = File.open(@vault.path_to(OUTPUT)).read
      stdout = File.open(@vault.path_to_stdout).read
      @result.result = FastReport::Report.new(output, stdout)
    end

    def run_successful?
      FileTest.exist?(@vault.path_to(OUTPUT))
    end
  end
end
