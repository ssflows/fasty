module FastReport
  class OutputParser
    BRANCH_REGULAR =
      /\s*(?=Branch\:\s+\d+)/
    SITE_REGULAR =
      /PositiveSelectionSite for branch\:\s+\d+\s+Site\:\s+\d+\s+Prob\:\s+\d+.\d+/
    def initialize(text)
      @text = text
    end

    def parse_branches
      @text.split(BRANCH_REGULAR)
           .map {|text| FastReport::Branch.new(text) }
    end

    def parse_sites
      @text.scan(SITE_REGULAR)
           .map{|text| FastReport::Site.new(text) }
    end

  end
end
