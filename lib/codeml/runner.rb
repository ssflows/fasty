class Codeml
  class Runner
    # @param[args[:vault]] A Vault object
    def initialize(args)
      @vault = args.fetch(:vault)
      @report = args.fetch(:report)
    end

    def execute
      @report.params = default_opts
      @vault.execute(Codeml::EXECUTABLE, default_opts)
    end

    def default_opts
      raise "Needs to be defined"
    end
    def default_opts
      " --noisy 9" +
      " --method 1" +
      " --preset M1" +
      " #{@vault.path_to(INPUT_ALIGNMENT)}"+
      " #{@vault.path_to(INPUT_TREE)}" +
      " #{@vault.path_to(OUTPUT)}"
    end
  end
end
