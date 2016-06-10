require 'charshift'

describe 'Charshift gem' do | |
  let(:string1) { "String one" }

  describe 'charshift method' do 
    it "returns an object of type string" do
      expect(string1.charshift(1)).to be_instance_of(String)
    end
  end

  it "shifts all characters the correct number of places on the default ASCII table" do
    expect(string1.charshift(1)).to eq("Tusjoh!ppf")
  end
end