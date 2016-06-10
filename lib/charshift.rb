require 'helper'

class String
  def charshift shift_val
    output = ""
    abs_shift_val = Helper.get_abs_shift_diff(shift_val, 128)
    self.split("").each do |char|
      output << char
    end
    return output
  end
end