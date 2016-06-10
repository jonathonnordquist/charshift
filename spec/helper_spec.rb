require 'helper'

describe 'Helper module' do
  let(:including_class) { Class.new { extend Helper } }

  describe 'confirm_int method' do
    let(:type_error) { 'Input value must be of type integer' }

    it 'raises an exception if it does not recieve an object of type int' do
      expect {
        Helper.confirm_int("aaaa")
      }.to raise_error(type_error)

      expect {
        Helper.confirm_int(0.7)
      }.to raise_error(type_error)
    end

    it 'returns true if it recieves an object of type int' do
      expect(Helper.confirm_int(7)).to be true
    end
  end

  describe 'get_abs_shift_diff method' do
    it 'returns the correct total distance to shift including overflow' do
      expect(Helper.get_abs_shift_diff(3, 10)).to eq(3)
      expect(Helper.get_abs_shift_diff(21, 57000)).to eq(21)
      expect(Helper.get_abs_shift_diff(55, 10)).to eq(5)
      expect(Helper.get_abs_shift_diff(5541, 23)).to eq(21)
      expect(Helper.get_abs_shift_diff(-96, 64871)).to eq(96)
      expect(Helper.get_abs_shift_diff(-5541, 23)).to eq(21)
      expect(Helper.get_abs_shift_diff(0, 54)).to eq(0)
    end
  end

  describe 'get_char_by_ord method' do
    it 'returns the correct value for a specific ordinal position' do
      expect(Helper.get_char_by_ord(47)).to eq("/")
      expect(Helper.get_char_by_ord(0)).to eq("\x00")
    end
  end
end