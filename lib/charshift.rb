require 'charshifthelper'

class String
  def charshift shift_val
    output = ""
    self.split("").each do |char|
      char_ord = CharshiftHelper.get_ord_by_char(char)
      p char_ord
      shifted_position = CharshiftHelper.get_shift_position(char_ord, shift_val)
      p shifted_position
      output << CharshiftHelper.get_char_by_ord(shifted_position)
    end
    return output
  end
end