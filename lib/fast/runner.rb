class Fast
  class Runner

    # @param[args[:vault]] A Vault object
    def initialize(args)
      @vault = args.fetch(:vault)
      @report = args.fetch(:report)
    end

    def execute
      @report.params = default_opts
      @vault.execute(Fast::EXECUTABLE, default_opts)
    end

    def default_opts
      " --no-pre-stop"               \
      " -nt 4"                       \
      " -v 4"                        \
      " -ou #{@vault.path_to(OUTPUT)}"   \
      " #{@vault.path_to(INPUT_TREE)}"         \
      " #{@vault.path_to(INPUT_ALIGNMENT)}"
      # " -p k=#{codeml.k}"            \
    end
  end
end
