# Purpose of this class is to create a Dictionary for keys in the
# initial alignment and to create an encoded alignment for further analysis.
class Encoder
  attr_reader :encoded_alignment, :dictionary

  # @param alignment [Alignment]
  def initialize(alignment)
    @input = alignment
    generate_dictionary
    encode
  end

  def generate_dictionary
    @dictionary = Dictionary.new(@input.keys)
  end

  # @return [Alignment] encoded Alignment
  def encode
    fasta = @input.to_fasta
    @input.keys.each do |key|
      fasta.gsub!(key, @dictionary.get_by_key(key))
    end
    @encoded_alignment = Alignment.new(fasta)
  end
end
