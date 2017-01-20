require_relative "fast_report/branch"
require_relative "fast_report/create_tree_with_positive"
require_relative "fast_report/output_parser"
require_relative "fast_report/site"
require_relative "fast_report/stdout_parser"
require 'json'

module FastReport
  class Report
    def initialize(output, stdout)
      @output = output
      @stdout = stdout
    end

    # @return [Array<FastOutput::Branch>]
    def branches
      @branches ||= output_parser.parse_branches
    end

    # @return [Array<FastOutput::Site>]
    def sites
      @sites ||= output_parser.parse_sites
    end

    # @return [Tree]
    def tree
      @tree ||= stdout_parser.parse_tree
    end

    # @return [Tree]
    def tree_with_positive
      @tree_positive ||= create_tree_with_positive
    end

    def to_hash
      {
        branches: branches.map(&:to_hash),
        sites: sites.map(&:to_hash)
      }
    end

    private

    def output_parser
      @output_parser ||= FastReport::OutputParser.new(@output)
    end

    def stdout_parser
      @stdout_parser ||= FastReport::StdoutParser.new(@stdout)
    end

    def create_tree_with_positive
      FastReport::CreateTreeWithPositive.new(tree, branches).run
    end
  end
end
