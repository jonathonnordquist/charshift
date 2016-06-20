require 'charshifthelper'
require 'byebug'

class String
  def charshift char_shift_val, custom_encoding = nil
    begin
      CharshiftHelper.confirm_fixnum(char_shift_val)
    rescue TypeError => e
      raise
    else
      output = ""
      split_string = CharshiftHelper.encoding_ind_split(self)
      if custom_encoding
        if CharshiftHelper.check_for_valid_array_elements(custom_encoding) == false
          raise TypeError, "Custom encoding must only contain single character string elements"
        elsif CharshiftHelper.check_for_uniqueness(custom_encoding) == false
          raise TypeError, "All elements in custom encoding must be unique"
        else
          return true
        end
      else
        split_string.each do |char|
          char_encoding_type = CharshiftHelper.get_encoding(char)
          encoding_length = CharshiftHelper.get_encoding_length(char_encoding_type) - 1
          current_char_ord = CharshiftHelper.get_ord_by_char(char)
          shifted_position = CharshiftHelper.get_shift_position(current_char_ord, char_shift_val, encoding_length)
          output << CharshiftHelper.get_char_by_ord(shifted_position, char_encoding_type)
        end
      end
      return output
    end
  end

  def getEncodingLength
    return CharshiftHelper.get_encoding_length(self.encoding)
  end
end