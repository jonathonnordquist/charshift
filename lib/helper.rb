module Helper

  def confirm_int input_val
    if !input_val.instance_of? Fixnum
      raise TypeError, 'Input value must be of type integer'
    else
      return true
    end
  end

  def get_abs_shift_diff input_val, collection_length
    if input_val > 0
      return collection_length % input_val
    elsif input_val < 0
      return 0 - (collection_length % input_val.abs)
    else
      return 0
    end
  end
end