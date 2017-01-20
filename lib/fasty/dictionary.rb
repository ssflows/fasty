class Dictionary
  ALPHABET = ("A".."Z").to_a + (0..9).to_a

  attr_reader :keys_to_codes

  # @param keys [Array]
  def initialize(keys)
    @keys = keys
    @codeset = generate_codeset(@keys.size)
    @keys_to_codes = Hash[@keys.zip(@codeset)]
    @codes_to_keys = Hash[@codeset.zip(@keys)]
  end

  # @param key [String]
  # @return [String, nil] code for key
  def get_by_key(key)
    @keys_to_codes[key]
  end

  # @param code [String]
  # @return [String, nil] key for code
  def get_by_code(code)
    @codes_to_keys[code]
  end

  def generate_codeset(size)
    size.times.map{generate_code}
  end

  def generate_code
    (0..9).map { ALPHABET[rand(35)] }.join
  end
end
