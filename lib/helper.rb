module Helper

  def confirm_int input_val
    if !input_val.instance_of? Integer
      raise TypeError, 'Input value must be of type integer'
    end
  end
end