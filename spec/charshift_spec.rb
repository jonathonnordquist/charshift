require 'charshift'

describe 'Charshift gem' do | |
  let(:string1) { "String one" }
  let(:string2) { "S" }

  describe 'charshift method' do 
    it "returns an object of type string" do
      expect(string1.charshift(1)).to be_instance_of(String)
    end
  end

  it "shifts all characters the correct number of places on the default ASCII table" do
    expect(string1.charshift(1)).to eq("Tusjoh!pof")
    expect(string1.charshift(60)).to eq("\u000F0.%*#\\+*!")
    expect(string2.charshift(-10)).to eq("I")
    expect(string2.charshift(-110)).to eq("e")
  end
end