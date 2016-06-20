require 'charshifthelper'
require 'byebug'

class String
  def charshift char_shift_val
    begin
      CharshiftHelper.confirm_fixnum(char_shift_val)
    rescue TypeError => e
      raise
    else
      output = ""
      split_string = []

      self.each_char do |chr|
        split_string << chr
      end
      split_string.each do |char|
        char_encoding_type = CharshiftHelper.get_encoding(char)
        encoding_length = CharshiftHelper.get_encoding_length(char_encoding_type)
        current_char_ord = CharshiftHelper.get_ord_by_char(char)
        shifted_position = CharshiftHelper.get_shift_position(current_char_ord, char_shift_val, encoding_length)
        output << CharshiftHelper.get_char_by_ord(shifted_position, char_encoding_type)
      end
      return output
    end
  end

  def getEncodingLength
    return CharshiftHelper.get_encoding_length(self.encoding)
  end
end