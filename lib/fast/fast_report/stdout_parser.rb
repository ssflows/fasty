module FastReport
  class StdoutParser
    def initialize(text)
      @text = text
    end

    def parse_tree
      tree_row = @text.split("\n")
                      .index("Annotated Newick tree (*N mark the internal branch N)")
      return nil unless tree_row
      tree = @text.split("\n")[tree_row + 2]
      Tree.new(newick: tree)
    end
  end
end
