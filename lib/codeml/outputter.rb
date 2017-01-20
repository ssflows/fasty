class Codeml
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
      result = File.open(@vault.path_to(OUTPUT)).read
      @result.report = CodemlResult.new(result)
    end

    def run_successful?
      FileTest.exist?(@vault.path_to(OUTPUT))
    end
  end
end
