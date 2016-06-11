module CharshiftHelper

  def self.confirm_int input_val
    if !input_val.instance_of? Fixnum
      raise TypeError, 'Input value must be of type integer'
    else
      return true
    end
  end

  def self.get_shift_diff input_val, collection_length
    abs_input_val = input_val.abs
    if abs_input_val > collection_length
      if input_val > 0
        return abs_input_val % collection_length
      elsif input_val < 0
        return 0 - (abs_input_val % collection_length)
      else
        return 0
      end
    else
      return input_val
    end
  end

  def self.get_shift_position starting_pos, shift_val
    collection_length = 128
    start_plus_shift = starting_pos + shift_val
    # p "start_plus_shift"
    # p start_plus_shift
    if start_plus_shift > collection_length
      # p "bigger"
      return 0 + start_plus_shift - collection_length
    elsif start_plus_shift < 0
      # p "smaller"
      return collection_length + start_plus_shift
    else
      # p "neither"
      return start_plus_shift
    end
  end

  def self.get_char_by_ord ordinal_value
    return ordinal_value.chr
  end

  def self.get_ord_by_char character
    return character.ord
  end
end