class Tree
  attr_reader :newick
  def initialize(newick:)
    @newick = newick
  end

  # @param identifiers [Array]
  # @return [String] trimmed tree in newick format
  def trim_for(identifiers)
    file = Tempfile.new("tree.nwk")
    File.open(file.path, "w") {|f| f << newick }

    `nw_prune -v #{file.path} #{identifiers.join(" ")}`.chomp
  ensure
    file.unlink
  end

  def branch_nums
    @newick.scan(/\*\d+/).map {|s| s.split("*").last.to_i }
  end

  def newick_without_inner_node_names
    newick.gsub(/\d+\.\d+\:\d+.\d+/) {|s| ":" + s.split(":").last }
  end

  # Should only be applied for trees with
  def fast_inn_node_names
    newick.scan(/\*\d+/).map {|s| s.split("*").last.to_i }
  end

  def to_file(&block)
    Tempfile.create("group#{group.id}_tree.nwk") do
      send_data(newick, type: "application/text", filename: 'tree.nwk')
    end
  end
end
