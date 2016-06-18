require 'charshift'

describe 'Charshift gem' do | |
  let(:string1) { "String one" }
  let(:string2) { "S" }
  let(:string3) { "S".encode("UTF-32BE") }
  let(:type_error) { TypeError }
  let(:type_error_text) { "Input value must be of type fixnum" }

  describe 'charshift method' do 
    it "returns an object of type string" do
      expect(string1.charshift(1)).to be_instance_of(String)
    end
  end

  it "shifts all characters the correct number of places for default UTF-8 encodings" do
    # UTF-8 has a range of 1114111 characters
    expect(string1.charshift(1)).to eq("Tusjoh!pof")
    expect(string1.charshift(60)).to eq("\u008F°®¥ª£\\«ª¡")
    expect(string1.charshift(-1)).to eq("Rsqhmf\x1Fnmd")
    expect(string1.charshift(-60)).to eq("\u001786-2+􏿣32)")
    expect(string2.charshift(10)).to eq("]")
    expect(string2.charshift(110)).to eq("Á")
    expect(string2.charshift(900)).to eq("ϗ")
    expect(string2.charshift(-10)).to eq("I")
    expect(string2.charshift(-110)).to eq("􏿤")
    expect(string2.charshift(-900)).to eq("􏳎")
    expect(string2.charshift(100000000)).to eq("\u{CE1AC}")
    expect(string2.charshift(-100000000)).to eq("\u{41EF9}")
  end

  # it "shifts all characters the correct number of places for non UTF-8 encodings" do
  #   expect('string3.charshift(350000000)').to end_with('{14DC93D3}')

  # end

  it "returns an error when given a non fixnum parameter" do
    expect { 
      string1.charshift("aaaa") 
    }.to raise_error(type_error, type_error_text)
    expect { 
      string1.charshift(1.0) 
    }.to raise_error(type_error, type_error_text)
  end
end


