class Alignment
  # @param fasta [String]
  def initialize(fasta)
    @ali = Bio::Alignment::MultiFastaFormat.new(fasta).alignment
  end

  def to_molphy(newline_after_this_many_bases: 100_00)
    @ali.output_molphy(width: newline_after_this_many_bases)
  end

  def to_phylip
    @ali.output_phylip
  end

  def to_fasta
    @ali.output_fasta
  end

  def to_ary
    keys = @ali.keys
    keys = keys.map {|k| k.class == Fixnum ? keys[k - 1] : k }
    keys.zip(@ali.entries)
  end

  def keys
    @ali.keys
  end
end
