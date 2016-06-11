require 'charshifthelper'

describe 'CharshiftHelper module' do
  let(:including_class) { Class.new { extend CharshiftHelper } }

  describe 'confirm_int method' do
    let(:type_error) { 'Input value must be of type integer' }

    it 'raises an exception if it does not recieve an object of type int' do
      expect {
        CharshiftHelper.confirm_int("aaaa")
      }.to raise_error(type_error)

      expect {
        CharshiftHelper.confirm_int(0.7)
      }.to raise_error(type_error)
    end

    it 'returns true if it recieves an object of type int' do
      expect(CharshiftHelper.confirm_int(7)).to be true
    end
  end

  describe 'get_shift_diff method' do
    it 'returns the correct total distance to shift including overflow' do
      expect(CharshiftHelper.get_shift_diff(3, 10)).to eq(3)
      expect(CharshiftHelper.get_shift_diff(21, 57000)).to eq(21)
      expect(CharshiftHelper.get_shift_diff(55, 10)).to eq(5)
      expect(CharshiftHelper.get_shift_diff(5541, 23)).to eq(21)
      expect(CharshiftHelper.get_shift_diff(-96, 64871)).to eq(-96)
      expect(CharshiftHelper.get_shift_diff(-5541, 23)).to eq(-21)
      expect(CharshiftHelper.get_shift_diff(0, 54)).to eq(0)
    end
  end

  describe 'get_shift_position method' do
    it 'returns the correct position on the character table as determined by the shift value' do
      expect(CharshiftHelper.get_shift_position(77, 5)).to eq(82)
      expect(CharshiftHelper.get_shift_position(122, 50)).to eq(44)
      expect(CharshiftHelper.get_shift_position(110, -10)).to eq(100)
      expect(CharshiftHelper.get_shift_position(10, -20)).to eq(118)
      expect(CharshiftHelper.get_shift_position(1, 385)).to eq(2)
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

end