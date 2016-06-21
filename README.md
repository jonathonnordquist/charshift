Charshift
=========

What does this do?
------------------
Charshift, as the name suggests, shifts characters.  More specifically each character has an ordinal indicator (raw number) which denotes its position for the strings character encoding.  For example, in Rubys default UTF-8 character encoding, the character "S" has an ordinal value of 83.  This encoding contains thousands of characters, what charshift does is takes an input string and shifts each character in the string to a higher or lower position in the encoding.

Installation
------------

Charshift is available as a gem, to install it run:
```ruby
gem install charshift
```
Or, if you're using Bundler, add it to your Gemfile:
```ruby
gem 'charshift'
```
And run:
```ruby
$ bundle install
```
Usage
-----

Charshift adds several methods to the String class.

To shift characters left or right simply call .charshift on any string object and pass it a positive or negative fixnum value.  For example:

```ruby
 > "Hello, World!".charshift(10)
=> "Rovvy6*ay|vn+" 
```

This shifts all values ten places to the 'right,' that is, each character output is it's original ordinal potion plus ten.

If the value passed is larger than the character set for the strings encoding the method will loop over the set and continue from the other side.  Charshift works will all of Rubys included encodings so if you're using something like Big5-HKSCS it will work as well as it does with the default UTF-8 character set.

Charshift also supports "custom encodings."  If you wish to use your own list of characters simply pass that list in the form an array as an optional second parameter:

```ruby
 > list = ["a", "W", "g", "d", " ", "H", "l", "k", "e", "o", "t", "!", ",", "r", "}", "D", "Y"]
 > "Hello, World!".charshift(10, list)
=> "DWYYgH}!glYr "
```

The value returned does not modify the original string, if you want to modify the string in place simply call '.charshift!' on the target string.

Finally, if you just want to see the number of characters for a strings encoding, use the '.getEncodingLength' method.

```ruby
 > "Hello, World!".getEncodingLength
=> 1114112
 > "Hello, World!".encode("ISO-2022-JP").getEncodingLength
=> 256
```
