class CodemlResult

  attr_reader :k, :tree, :p0, :p1, :w0, :w1

  # @param[String] Content of output file
  def initialize(output)
    @raw = output
    process
  end

  private

  def process
    @raw.lines.each { |l| parse_line (l) }
  end

  def parse_line(l)
    if l =~ /^kappa \(ts\/tv\) =/
      @k = l.split('=').last.to_f
    elsif l =~ /^\(.+: ([0-9]*\.[0-9]+|[0-9]), \(.+:/
      @tree = l.chomp.squish
    elsif l =~ /^p:\s+ ([0-9]*\.[0-9]+|[0-9])\s+([0-9]*\.[0-9]+|[0-9])$/
      @p0 = l.split(' ')[1].to_f
      @p1 = l.split(' ')[2].to_f
    elsif l =~ /^w:\s+ ([0-9]*\.[0-9]+|[0-9])\s+([0-9]*\.[0-9]+|[0-9])$/
      @w0 = l.split(' ')[1].to_f
      @w1 = l.split(' ')[2].to_f
    end
  end
end
