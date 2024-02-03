module Spec::Support
  ALPHANUMERIC_CHARS = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

  # Generate unique app key.
  #
  # Example:
  # ```
  # # Generate data for test.
  # unique_app_key = Spec::Support.generate_unique_app_key
  # ```
  #
  def self.generate_unique_app_key : String
    result : String = ""
    # Shuffle symbols in random order.
    shuffled_chars : Array(String) = ALPHANUMERIC_CHARS.split("").shuffle
    #
    chars_count : Int32 = shuffled_chars.size - 1
    size : Int32 = 16
    size.times do
      result += shuffled_chars[Random.rand(chars_count)]
    end
    result
  end
end
