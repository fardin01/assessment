class Humanize
	require File.join(File.dirname(__FILE__), 'base_numbers')

	def initialize(number)
			@number = number
			@length = number.to_s.size
			@digits = number.to_s.split('').map{ |number| number.to_i}
	end

	def to_word
		process_length.gsub(/\b( Zero Hundred| Zero Thousand| Zero Million|.Zero)\b/, '')
		#gsub here fixes the sentence when there is 0's somewhere in the number
		#e.g. 100 => "One Hundred Zero" => "One Hundred" or 10001 =>"Ten Thousand Zero Hundred One" => "Ten Thousand One"
	end
			
	def process_length
		case
		when @length == 1 then singles
		when @length == 2 then tens
		when @length == 3 then hundreds
		when (4..6) === @length then thousands
		when (7..9) === @length then millions
		when (10..12) === @length then billions
		end
	end

	def singles(number = @number)
		SINGLES.fetch(number)
	end

	def tens(digits = @digits)
	  case 
	  when FIRST_TENS.include?(@number) then FIRST_TENS.fetch(@number) #This line triggers only when the input is 2 digits(11..99)
	  when digits.join.to_i <= 19 then SINGLES.merge(FIRST_TENS).fetch(digits.join.to_i) #This line triggers when input is (100..119)
	  else SECOND_TENS.fetch(digits.first * 10) + " " + SINGLES.fetch(digits.last) #This line triggers when input is (120..n)
	  end
	end	

	def hundreds(digits = @digits)
		singles(digits.first) + " Hundred " + tens(digits[1..2].map{|n| n.to_i}) 
	end

	def thousands(digits = @digits, length = @length)
		case 
		when length == 4 then singles(digits.first) + " Thousand " + hundreds(digits[1..3])
		when length == 5 then tens(digits[0..1]) + " Thousand " + hundreds(digits[2..4])
		when length == 6 then hundreds(digits[0..2]) + " Thousand " + hundreds(digits[3..5])	
		end
	end

	def millions(digits = @digits, length = @length)
		case 
		when length == 7 then singles(digits.first) + " Million " + thousands(digits[1..6], 6)
		when length == 8 then tens(digits[0..1]) + " Million " + thousands(digits[2..7], 6)
		when length == 9 then hundreds(digits[0..2]) + " Million " + thousands(digits[3..8], 6)
		end
	end

	def billions(digits = @digits, length = @length)
		case
		when length == 10 then singles(digits.first) + " Billion " + millions(digits[1..9], 9)
		when length == 11 then tens(digits[0..1]) + " Billion " + millions(digits[2..10], 9)
		when length == 12 then hundreds(digits[0..2]) + " Billion " + millions(digits[3..11], 9)
		end
	end
end