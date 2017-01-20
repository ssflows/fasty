require 'json'

module Fasty
  class PipelineRunner

    def initialize
      create_workdir
      encode_alignment
    end

    def run_things  
      @guidance_result = Guidance.new(@workdir).execute(input: @encoded_orig_alignment.to_fasta)
      @phyml_result = Phyml.new(@workdir).execute(input: @guidance_result.alignment.to_molphy)
      @codeml_result = Codeml.new(@workdir).execute(input: {alignment: @guidance_result.alignment.to_fasta, tree: @phyml_result.tree})
      @fast_result = Fast.new(@workdir).execute(input: {alignment: @guidance_result.alignment.to_molphy, tree: @phyml_result.tree})
    end

    def execute
      run_things
      File.open(File.join(@workdir, "report.json"), "w") {|f| f << final_report }
      puts 'Success'
    end

    def final_report
      {
        alignment: @guidance_result.alignment.to_fasta,
        tree: @phyml_result.tree,
        fastcodeml: @fast_result.result
      }.to_json
    end

    def create_workdir
      @workdir = "/workdir/fasty_run_" + Time.now.to_i.to_s
      Dir.mkdir(@workdir)
    end

    def encode_alignment
      @orig_alignment = Alignment.new(File.open("/workdir/alignment.fasta").read)
      enc = Encoder.new(@orig_alignment)
      @encoded_orig_alignment = enc.encoded_alignment
      @dictionary = enc.dictionary
    end

  end
end
