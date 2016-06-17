require 'charshifthelper'

describe 'CharshiftHelper module' do
  let(:including_class) { Class.new { extend CharshiftHelper } }

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
      expect(CharshiftHelper.get_shift_position(77, 5)).to eq(82)
      expect(CharshiftHelper.get_shift_position(122, 50)).to eq(44)
      expect(CharshiftHelper.get_shift_position(110, -10)).to eq(100)
      expect(CharshiftHelper.get_shift_position(10, -20)).to eq(118)
      expect(CharshiftHelper.get_shift_position(1, 385)).to eq(2)
      expect(CharshiftHelper.get_shift_position(1, -250)).to eq(7)
      expect(CharshiftHelper.get_shift_position(127, 254)).to eq(125)
      expect(CharshiftHelper.get_shift_position(127, -254)).to eq(1)
    end
  end

  describe 'get_char_by_ord method' do
    it 'returns the correct value for a specific ordinal position' do
      expect(CharshiftHelper.get_char_by_ord(47)).to eq("/")
      expect(CharshiftHelper.get_char_by_ord(0)).to eq("\x00")
    end
  end

  describe 'get_ord_by_char method' do
    it 'returns the ordinal position for the input character' do
      expect(CharshiftHelper.get_ord_by_char('A')).to eq(65)
      expect(CharshiftHelper.get_ord_by_char(" ")).to eq(32)
    end
  end

  describe 'get_encoding_length method' do
    it 'returns the number of available positons for a given encoding' do
      expect(CharshiftHelper.get_encoding_length("ASCII-8BIT")).to eq(255)
      expect(CharshiftHelper.get_encoding_length("UTF-16BE")).to eq(1114111)
      expect(CharshiftHelper.get_encoding_length("UTF-32")).to eq(4294967295)
      expect(CharshiftHelper.get_encoding_length("GB18030")).to eq(64766)
      expect(CharshiftHelper.get_encoding_length("Shift_JIS")).to eq(223)
    end
  end 

end