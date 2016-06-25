require_relative '../ruby_numerals'

describe Humanize do 
  require_relative 'test_numbers'

	TESTS.each do |number, word|
    it "#{number} in words is #{word}" do
      expect(Humanize.new(number).to_word). to eql(word)
    end
  end 
end