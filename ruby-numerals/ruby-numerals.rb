class Humanize

	SINGLES = {0 => "Zero", 1 => "One", 2 => "Two", 3 => "Three", 4 => "Four", 5 => "Five", 6 => "Six", 7 => "Seven", 8 => "Eight", 9 => "Nine"}
	FIRST_TENS = {11 => "Eleven", 12 => "Twelve", 13 => "Thirteen", 14 => "Fourteen", 15 => "Fifteen", 16 => "Sixteen", 17 => "Seventeen", 18 => "Eighteen", 19 => "Nineteen"}
	SECOND_TENS = {20 => "Twenty", 30 => "Thirty", 40 => "Fourty", 50 => "Fifty", 60 => "Sixty", 70 => "Sventy", 80 => "Eighty", 90 => "Ninety"}

	def initialize(num)
			@number = num
			@length = num.to_s.size
			@digits = number.to_s.split('').map{ |number| number.to_i}
	end

	def to_word
		if @length == 1
			singles
		elsif @length == 2
			tens
		elsif @length == 3
			hundreds
		elsif (4..6) === @length
			thousands
		elsif (7..9) === @length
			millions
		elsif (10..12) === @length
			billions
		end
	end
				
	def singles(number = @number)
		SINGLES.fetch(number)
	end

	def tens(digits = @digits)
		if FIRST_TENS.include?(@number)
			FIRST_TENS.fetch(@number)
		elsif digits.join.to_i <= 19
			SINGLES.merge(FIRST_TENS).fetch(digits.join.to_i)
		else
			SECOND_TENS.fetch(digits.first * 10) + " " + SINGLES.fetch(digits.last)
		end
	end

	def hundreds(digits = @digits)
		singles(digits.first) + " Hundred and " + tens(digits[1..2].map{|n| n.to_i}) #tens returns array
	end

	def thousands(digits = @digits, length = @length)
		if length == 4
			singles(digits.first) + " Thousand and " + hundreds(digits[1..3])
		elsif length == 5
			tens(digits[0..1]) + " Thousand and " + hundreds(digits[2..4])
		elsif length == 6
			hundreds(digits[0..2]) + " Thousand and " + hundreds(digits[3..5])
		end
	end

	def millions(digits = @digits, length = @length)
		if length  == 7
			singles(digits.first) + " Million and " + thousands(digits[1..6], 6)
		elsif length == 8
			tens(digits[0..1]) + " Million and " + thousands(digits[2..7], 6)
		elsif length == 9
			hundreds(digits[0..2]) + " Million and " + thousands(digits[3..8], 6)
		end
	end

	def billions
		if @length  == 10
			singles(@digits.first) + " Billion and " + millions(@digits[1..9], 9)
		elsif @length == 11
			tens(@digits[0..1]) + " Billion and " + millions(@digits[2..10], 9)
		elsif @length == 12
			hundreds(@digits[0..2]) + " Billion and " + millions(@digits[3..11], 9)
		end
	end
end