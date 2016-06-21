Gem::Specification.new do |s|
  s.name        = 'charshift'
  s.version     = '0.2.1'
  s.date        = '2016-06-10'
  s.summary     = "Facilitate character change by ordinal position"
  s.description = <<-EOF
                  Charshift is a simple gem which adds functionality to the
                  String class.  It's primary function is to act on a given
                  string, taking a fixnum parameter, then shifting each 
                  character in that string to a higher or lower ordinal 
                  position in that strings encoding.

                  Charshift works with all of Ruby's included encodings and 
                  also works with devloper supplied 'custom encodings.'  
                  Simply provide an ordered set of characters as an optional
                  parameter and charshift will work on the string using that
                  set instead of the strings native encoding.

                  Charshift also includes a '.getEncodingLength' method which
                  returns the number of of characters which a given strings 
                  encoding contains.  Finally, strings can be shifted in place
                  using the '.charshift!' method.

                  EOF
  s.authors     = ["Jonathon Nordquist"]
  s.email       = 'https://github.com/cugamer/charshift'
  s.files       = ["lib/charshift.rb", "lib/charshifthelper.rb"]
  s.homepage    =
    'http://www.jonathonnordquist.com'
  s.license       = 'MIT'
end