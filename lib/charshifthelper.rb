module CharshiftHelper

  def self.confirm_fixnum input_val
    if !input_val.instance_of? Fixnum
      raise TypeError, 'Input value must be of type fixnum'
    else
      return true
    end
  end

  def self.get_shift_distance_minus_loops input_val, collection_length
    absloute_input_val = input_val.abs
    remaining_difference = absloute_input_val % collection_length
    if absloute_input_val > collection_length
      return input_val > 0 ? remaining_difference : 0 - remaining_difference
    else
      return input_val
    end
  end

  def self.get_shift_position starting_pos, shift_val, encoding_length
    collection_length = encoding_length
    shift_difference = self.get_shift_distance_minus_loops(shift_val, collection_length)
    start_plus_shift = starting_pos + shift_difference
    if start_plus_shift > collection_length
      return 0 + start_plus_shift - collection_length
    elsif start_plus_shift < 0
      return collection_length + start_plus_shift
    else
      return start_plus_shift
    end
  end

  def self.get_char_by_ord ordinal_value, char_encoding_type
    return ordinal_value.chr(char_encoding_type)
  end

  def self.get_ord_by_char character
    return character.ord
  end

  def self.get_encoding string
    return string.encoding.to_s
  end

  def self.get_encoding_length encoding
    max = 100000000000
    min = 0
    guess = 50000000000

    while true
      begin guess.chr(encoding)
        if (min > max)
          return max + 1
        else
          min = guess + 1
          guess = (max + min) / 2
        end
      rescue
        if min > max
          return max + 1
        else
          max = guess - 1
          guess = (max + min) / 2
        end
      end
    end
  end
end