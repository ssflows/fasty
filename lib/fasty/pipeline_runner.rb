require 'json'

module Fasty
  class PipelineRunner

    def initialize(input)
      @input_file = input
      create_workdir
      encode_alignment
    end

    def run_things
      @guidance_result = Guidance.new(@workdir).execute(input: @encoded_orig_alignment.to_fasta)
      @phyml_result = Phyml.new(@workdir).execute(input: @guidance_result.alignment.to_molphy)
      @codeml_result = Codeml.new(@workdir).execute(input: {alignment: @guidance_result.alignment.to_molphy, tree: @phyml_result.tree.newick_without_inner_node_names})
      @fast_result = Fast.new(@workdir).execute(input: {alignment: @guidance_result.alignment.to_molphy, tree: @codeml_result.report.tree})
    end

    def execute
      run_things
      File.open(File.join(@workdir, "report.json"), "w") {|f| f << final_report }
      decode_everything
      chown_everything
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
      @orig_alignment = Alignment.new(File.open("/workdir/#{@input_file}").read)
      enc = Encoder.new(@orig_alignment)
      @encoded_orig_alignment = enc.encoded_alignment
      @dictionary = enc.dictionary
    end

    def decode_everything
      @dictionary.codes_to_keys.each do |code, key|
        `grep -rl '#{code}' #{@workdir} | xargs sed -i 's/#{code}/#{key}/g'`
      end
    end

    def chown_everything
      uid = File.stat("/workdir/#{@input_file}").uid
      gid = File.stat("/workdir/#{@input_file}").gid
      `chown -R #{uid}:#{gid} #{@workdir}`
    end

  end
end
