require 'charshifthelper'

describe 'CharshiftHelper module' do
  let(:including_class) { Class.new { extend CharshiftHelper } }
  let(:string1) { "String one" }
  describe 'confirm_fixnum method' do
    let(:type_error) { 'Input value must be of type fixnum' }

    it 'raises an exception if it does not recieve an object of type int' do
      expect {
        CharshiftHelper.confirm_fixnum("aaaa")
      }.to raise_error(type_error)

      expect {
        CharshiftHelper.confirm_fixnum(0.7)
      }.to raise_error(type_error)
    end

    it 'returns true if it recieves an object of type int' do
      expect(CharshiftHelper.confirm_fixnum(7)).to be true
    end
  end

  describe 'get_shift_distance_minus_loops method' do
    it 'returns the correct total distance to shift including overflow' do
      expect(CharshiftHelper.get_shift_distance_minus_loops(3, 10)).to eq(3)
      expect(CharshiftHelper.get_shift_distance_minus_loops(21, 57000)).to eq(21)
      expect(CharshiftHelper.get_shift_distance_minus_loops(55, 10)).to eq(5)
      expect(CharshiftHelper.get_shift_distance_minus_loops(5541, 23)).to eq(21)
      expect(CharshiftHelper.get_shift_distance_minus_loops(-96, 64871)).to eq(-96)
      expect(CharshiftHelper.get_shift_distance_minus_loops(-5541, 23)).to eq(-21)
      expect(CharshiftHelper.get_shift_distance_minus_loops(0, 54)).to eq(0)
    end
  end

  describe 'get_shift_position method' do
    it 'returns the correct position on the character table as determined by the shift value' do
      expect(CharshiftHelper.get_shift_position(77, 5, 1114111)).to eq(82)
      expect(CharshiftHelper.get_shift_position(122, 50, 1114111)).to eq(172)
      expect(CharshiftHelper.get_shift_position(110, -10, 1114111)).to eq(100)
      expect(CharshiftHelper.get_shift_position(10, -20, 1114111)).to eq(1114101)
      expect(CharshiftHelper.get_shift_position(1, 385, 1114111)).to eq(386)
      expect(CharshiftHelper.get_shift_position(1, -250, 1114111)).to eq(1113862)
      expect(CharshiftHelper.get_shift_position(127, 254, 1114111)).to eq(381)
      expect(CharshiftHelper.get_shift_position(127, -254, 1114111)).to eq(1113984)
    end
  end

  describe 'get_char_by_ord method' do
    it 'returns the correct value for a specific ordinal position' do
      expect(CharshiftHelper.get_char_by_ord(47, "UTF-8")).to eq("/")
      expect(CharshiftHelper.get_char_by_ord(0, "UTF-8")).to eq("\x00")
    end
  end

  describe 'get_ord_by_char method' do
    it 'returns the ordinal position for the input character' do
      expect(CharshiftHelper.get_ord_by_char('A')).to eq(65)
      expect(CharshiftHelper.get_ord_by_char(" ")).to eq(32)
    end
  end

  describe 'get_encoding method' do
    it 'returns the encoding type for a given string' do
      expect(CharshiftHelper.get_encoding('a')).to eq("UTF-8")
      expect(CharshiftHelper.get_encoding(50000.chr("UTF-32BE"))).to eq("UTF-32BE")
    end
  end

  describe 'get_encoding_length method' do
    it 'returns the number of available positons for a given encoding' do
      expect(CharshiftHelper.get_encoding_length("ASCII-8BIT")).to eq(256)
      expect(CharshiftHelper.get_encoding_length("UTF-16BE")).to eq(1114112)
      expect(CharshiftHelper.get_encoding_length("UTF-32")).to eq(4294967296)
      expect(CharshiftHelper.get_encoding_length("GB18030")).to eq(64767)
      expect(CharshiftHelper.get_encoding_length("Shift_JIS")).to eq(224)
    end
  end

  describe 'encoding_ind_split' do
    it 'takes a string and returns an array of individual characters' do
      expect(CharshiftHelper.encoding_ind_split(string1)).to eq(["S", "t", "r", "i", "n", "g", " ", "o", "n", "e"])
      expect(CharshiftHelper.encoding_ind_split(string1.encode("UTF8-MAC"))).to eq(["S", "t", "r", "i", "n", "g", " ", "o", "n", "e"])
      expect(CharshiftHelper.encoding_ind_split(string1.encode("Windows-31J"))).to eq(["S", "t", "r", "i", "n", "g", " ", "o", "n", "e"])
      expect(CharshiftHelper.encoding_ind_split(string1.encode("Emacs-Mule"))).to eq(["S", "t", "r", "i", "n", "g", " ", "o", "n", "e"])
      expect(CharshiftHelper.encoding_ind_split(string1.encode("IBM862"))).to eq(["S", "t", "r", "i", "n", "g", " ", "o", "n", "e"])
      expect(CharshiftHelper.encoding_ind_split(string1.encode("macUkraine"))).to eq(["S", "t", "r", "i", "n", "g", " ", "o", "n", "e"])
      expect(CharshiftHelper.encoding_ind_split(string1.encode("UTF-32LE"))).to eq(["S".encode("UTF-32LE"), "t".encode("UTF-32LE"), 
                                                                                      "r".encode("UTF-32LE"), "i".encode("UTF-32LE"), 
                                                                                      "n".encode("UTF-32LE"), "g".encode("UTF-32LE"), 
                                                                                      " ".encode("UTF-32LE"), "o".encode("UTF-32LE"), 
                                                                                      "n".encode("UTF-32LE"), "e".encode("UTF-32LE")])
    end

    describe 'check_for_valid_array_elements method' do
      it 'returns true if all elements in an array are single character strings' do
        expect(CharshiftHelper.check_for_valid_array_elements(["a", "b", "C"])).to be true
        expect(CharshiftHelper.check_for_valid_array_elements(["a", "b", "1"])).to be true
        expect(CharshiftHelper.check_for_valid_array_elements(["Q", ":", "0"])).to be true
      end

      it 'returns false if array contains non string elements' do
        expect(CharshiftHelper.check_for_valid_array_elements([0, "a", 1, "C"])).to be false
        expect(CharshiftHelper.check_for_valid_array_elements(["a", 1, "C"])).to be false
      end

      it 'returns falise if array contains mulicharacter strings' do
        expect(CharshiftHelper.check_for_valid_array_elements(["aa", "b", "C"])).to be false
        expect(CharshiftHelper.check_for_valid_array_elements(["q", "aa", "b", "C"])).to be false
      end
    end

    describe 'check_for_uniqueness method' do
      it 'returns true if all elements in array are unique' do
        expect(CharshiftHelper.check_for_uniqueness(["a", "b", "c", "d"])).to be true
      end

      it 'returns false if any elements in array are not unique' do
        expect(CharshiftHelper.check_for_uniqueness(["a", "b", "c", "a"])).to be false
        expect(CharshiftHelper.check_for_uniqueness(["a", "a", "c", "d"])).to be false
      end
    end
  end

end