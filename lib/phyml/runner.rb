class Phyml
  class Runner
    # @param[args[:vault]] A Vault object
    def initialize(args)
      @vault = args.fetch(:vault)
      @report = args.fetch(:report)
    end

    def execute
      @report.params = default_opts
      @vault.execute(EXECUTABLE, default_opts)
    end

    def default_opts
      "-q -i #{@vault.path_to(INPUT)}"
    end
  end
end
