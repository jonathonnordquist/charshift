module Helper

  def self.confirm_int input_val
    if !input_val.instance_of? Fixnum
      raise TypeError, 'Input value must be of type integer'
    else
      return true
    end
  end

  def self.get_abs_shift_diff input_val, collection_length
    abs_input_val = input_val.abs
    if abs_input_val > collection_length
      return abs_input_val % collection_length
    else
      return abs_input_val
    end
  end

  def self.get_char_by_ord ordinal_value
    return ordinal_value.chr
  end
end