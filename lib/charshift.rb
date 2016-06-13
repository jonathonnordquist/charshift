require 'charshifthelper'

class String
  def charshift char_shift_val
    begin
      CharshiftHelper.confirm_int(char_shift_val)
    rescue TypeError => e
      raise
    else
      output = ""
      self.split("").each do |char|
        current_char_ord = CharshiftHelper.get_ord_by_char(char)
        shifted_position = CharshiftHelper.get_shift_position(current_char_ord, char_shift_val)
        output << CharshiftHelper.get_char_by_ord(shifted_position)
      end
      return output
    end
      
  end
end