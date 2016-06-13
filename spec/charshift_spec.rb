require 'charshift'

describe 'Charshift gem' do | |
  let(:string1) { "String one" }
  let(:string2) { "S" }
  let(:type_error) { TypeError }
  let(:type_error_text) { "Input value must be of type integer" }

  describe 'charshift method' do 
    it "returns an object of type string" do
      expect(string1.charshift(1)).to be_instance_of(String)
    end
  end

  it "shifts all characters the correct number of places on the default ASCII table" do
    expect(string1.charshift(1)).to eq("Tusjoh!pof")
    expect(string1.charshift(60)).to eq("\u000F0.%*#\\+*!")
    expect(string1.charshift(-1)).to eq("Rsqhmf\x1Fnmd")
    expect(string1.charshift(-60)).to eq("\x1786-2+d32)")
    expect(string2.charshift(10)).to eq("]")
    expect(string2.charshift(110)).to eq("A")
    expect(string2.charshift(900)).to eq("W")
    expect(string2.charshift(-10)).to eq("I")
    expect(string2.charshift(-110)).to eq("e")
    expect(string2.charshift(-900)).to eq("O")
  end

  it "returns an error when given a non fixnum parameter" do
    expect { 
      string1.charshift("aaaa") 
    }.to raise_error(type_error, type_error_text)
    expect { 
      string1.charshift(1.0) 
    }.to raise_error(type_error, type_error_text)
  end
end