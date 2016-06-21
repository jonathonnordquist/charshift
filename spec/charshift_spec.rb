require 'charshift'

describe 'Charshift gem' do | |
  let(:string1) { "String one" }
  let(:string2) { "S" }
  let(:string3) { "S".encode("UTF-32BE") }
  let(:string4) { "aqrl?Q:7g" }
  let(:string5) { "q" }
  let(:string10) {  "Hello, World!" }
  let(:type_error) { TypeError }
  let(:argument_error) { ArgumentError }
  let(:runtime_error) { RuntimeError }
  let(:missing_chars_runtime_error_text) { "Given custom encoding does not contain all characters in the target string" }
  let(:non_fixnum_type_error_text) { "Input value must be of type fixnum" }
  let(:non_unique_argument_error_text) { "All elements in custom encoding must be unique" }
  let(:invalid_custom_chars_argument_error_text) { "Custom encoding must only contain single character string elements" }
  let(:custom_encoding1) { ["a", "g", "q", "r", "l", "k", "?", "Q", ":", "]", "7", "9"] }
  let(:custom_encoding2) { ["a", "W", "g", "d", " ", "H", "l", "k", "e", "o", "t", "!", ",", "r", "}", "D", "Y"] }

  describe 'charshift method' do 
    it "returns an object of type string" do
      expect(string1.charshift(1)).to be_instance_of(String)
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

    it "shifts all characters the correct number of places when given a custom encoding" do
      expect(string5.charshift(1, custom_encoding1)).to eq("r")
      expect(string5.charshift(50, custom_encoding1)).to eq("l")
      expect(string5.charshift(-2, custom_encoding1)).to eq("a")
      expect(string5.charshift(-52, custom_encoding1)).to eq("7")
      expect(string10.charshift(10, custom_encoding2)).to eq("DWYYgH}!glYr ")
      expect(string10.charshift(-10, custom_encoding2)).to eq(",DrrYg!eYdrtW")
      expect(string10.charshift(30, custom_encoding2)).to eq("W ggHea}HogYk")
      expect(string10.charshift(-30, custom_encoding2)).to eq("o,ttrYeHratkD")
    end


    # it "shifts all characters the correct number of places for non UTF-8 encodings" do
    #   expect('string3.charshift(350000000)').to end_with('{14DC93D3}')

    # end

    it 'raises "TypeError" when given a custom encoding with non unique values' do
      expect {
        string1.charshift(5, ["a", "b", "C", "a"])
      }.to raise_error(argument_error, non_unique_argument_error_text)
      expect {
        string1.charshift(5, ["a", "a", "C", "d"])
      }.to raise_error(argument_error, non_unique_argument_error_text)
    end

    it 'raises "TypeError" when given a custom encoding with invalid values' do
      expect {
        string1.charshift(5, [1, 2, "C", "a"])
      }.to raise_error(argument_error, invalid_custom_chars_argument_error_text)
      expect {
        string1.charshift(5, [1, "a", 2, "d"])
      }.to raise_error(argument_error, invalid_custom_chars_argument_error_text)
      expect {
        string1.charshift(5, ["aa", "a", "C", "d"])
      }.to raise_error(argument_error, invalid_custom_chars_argument_error_text)
      expect {
        string1.charshift(5, ["aa", "aa", 2, "d"])
      }.to raise_error(argument_error, invalid_custom_chars_argument_error_text)
    end

    it 'raises "RuntimeError" when given a custom encoding which does not contain all characters present in a string' do
      expect {
        string1.charshift(5, ["a", "g", "k", "t", "W", "!", "}", "D", "Y"])
      }.to raise_error(runtime_error, missing_chars_runtime_error_text)
    end

    it "raises an error when given a non fixnum parameter" do
      expect { 
        string1.charshift("aaaa") 
      }.to raise_error(type_error, non_fixnum_type_error_text)
      expect { 
        string1.charshift(1.0) 
      }.to raise_error(type_error, non_fixnum_type_error_text)
    end
  end

  describe 'charshift! method' do
    let(:string6) { "P" }
    let(:string7) { "String seven" }
    let(:string8) { "P" }
    let(:string9) { "String seven" }

    it 'executes the character shift in place' do
      string6.charshift!(1)
      string7.charshift!(500)
      expect(string6).to eq("Q")
      expect(string7).to eq("ɇɨɦɝɢɛȔɧəɪəɢ")
    end

    it 'returns the value of the shifted string' do
      expect(string8.charshift!(1)).to eq("Q")
      expect(string9.charshift!(500)).to eq("ɇɨɦɝɢɛȔɧəɪəɢ")
    end
  end

  describe 'getEncodingLength method' do
    it 'returns the correct number of available values for a strings current encoding' do
      expect(string1.getEncodingLength).to eq(1114112)
      expect(string1.encode("UTF8-MAC").getEncodingLength).to eq(1114112)
      expect(string1.encode("Windows-31J").getEncodingLength).to eq(224)
      expect(string1.encode("Emacs-Mule").getEncodingLength).to eq(128)
      expect(string1.encode("IBM862").getEncodingLength).to eq(256)
      expect(string1.encode("macUkraine").getEncodingLength).to eq(256)
      expect(string1.encode("UTF-32LE").getEncodingLength).to eq(4294967296)
    end
  end

end



