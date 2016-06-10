module Helper

  def confirm_int input_val
    if !input_val.instance_of? Fixnum
      raise TypeError, 'Input value must be of type integer'
    else
      return true
    end
  end
end