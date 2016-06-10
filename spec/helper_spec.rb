require 'helper'

describe 'Helper module' do
  let(:including_class) { Class.new { extend Helper } }

  describe 'confirm_int method' do
    let(:type_error) { 'Input value must be of type integer' }

    it 'raises an exception if it does not recieve an object of type int' do
      expect {
        including_class.confirm_int("aaaa")
      }.to raise_error(type_error)

      expect {
        including_class.confirm_int(0.7)
      }.to raise_error(type_error)
    end

    it 'returns true if it recieves an object of type int' do
      expect(including_class.confirm_int(7)).to be true
    end
  end
end