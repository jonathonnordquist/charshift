require 'charshift'

describe 'Charshift gem' do | |
  let(:string1) { "String one" }

  describe 'charshift method' do 
    it "returns an object of type string" do
      expect(string1.charshift(1)).to be_instance_of(String)
    end
  end
end