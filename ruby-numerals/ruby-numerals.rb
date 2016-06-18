class Humanize

	SINGLES = {0 => "zero", 1 => "One", 2 => "Two", 3 => "Three", 4 => "Four", 5 => "Five", 6 => "Six", 7 => "Seven", 8 => "Eight", 9 => "Nine"}
	FIRST_TENS = {11 => "Eleven", 12 => "Twelve", 13 => "Thirteen", 14 => "Fourteen", 15 => "Fifteen", 16 => "Sixteen", 17 => "Seventeen", 18 => "Eighteen", 19 => "Nineteen"}
	SECOND_TENS = {20 => "Twenty", 30 => "Thirty", 40 => "Fourty", 50 => "Fifty", 60 => "Sixty", 70 => "Sventy", 80 => "Eighty", 90 => "Ninety"}

	def initialize(num)
			@number = num
			@length = num.to_s.size
	end

	def to_word
		if @length == 1
			singles
		elsif @length == 2
			tens
		elsif @length == 3
			hundreds
		elsif @length == 4 || 5 || 6
			thousands
		elsif @length == 7 || 8 || 9
			millions
		elsif @length == 10 || 11 || 12
			billions
		end
	end
				
	def singles(number = @number)
		SINGLES.fetch(number)
	end

		def tens
		if FIRST_TENS.include?(@number)
			FIRST_TENS.fetch(@number)
		else
			SECOND_TENS.fetch(@digits.first * 10) + " " + SINGLES.fetch(@digits.last)
		end
	end

end