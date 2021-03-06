class Guidance
  class Runner

    # @param[args[:vault]] A Vault object
    def initialize(args)
      @vault = args.fetch(:vault)
      @report = args.fetch(:report)
    end

    def execute
      @report.params = default_opts
      @vault.execute(EXEC, default_opts)
    end

    private

    def default_opts
      "--seqFile #{@vault.path_to(INPUT)} " \
      "--msaProgram MAFFT " \
      "--seqType codon " \
      "--outDir #{@vault.path_to(OUTPUT)} " \
      "--proc_num #{ENV['PPTHREADS'] || 1}" \
    end
  end
end
