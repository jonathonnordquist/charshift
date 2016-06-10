require 'helper'

class String
  def charshift shift_val
    output = ""
    abs_shift_val = Helper.get_shift_diff(shift_val, 128)
    self.split("").each do |char|
      char_ord = Helper.get_ord_by_char(char)
      output << Helper.get_char_by_ord(char_ord + abs_shift_val)
    end
    return output
  end
end