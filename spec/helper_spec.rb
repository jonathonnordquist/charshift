require 'helper'

describe 'Helper module' do
    let(:including_class) { Class.new { extend Helper } }

   describe 'confirm_int method' do

    it 'raises an exception if it does not recieve an object of type int' do
      expect {
        including_class.confirm_int("aaaa")
      }.to raise_error('Input value must be of type integer')
    end
  end
end