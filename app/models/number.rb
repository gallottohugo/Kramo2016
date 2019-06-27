class Number < ActiveRecord::Base
	
	before_create :validation_input

	after_create :validation_equals, :validation_regular

		
	

	belongs_to :match
	belongs_to :player


	



	def validation_input
		#validamos si el numero tiene digitos distintos.
		@array_elements = ["0","1","2","3","4","5","6","7","8","9"]
		#.split convierte un string en un array
		@number = self.number.split(//)
		@array_elements.each do |i|	
			@count = 0
			@number.each do |e|
				if i == e then
					@count += 1
					if @count > 1 then
						return false
					end
				end
			end
		end
	end

	def validation_equals
		#comparar el numero que ingreso contra el numero a adivinar y ver cuantos mal, regular y bien hay
		nro1 = "1234".split("")
		nro2 = "0734".split("")
		cant = nro1.size
		equals = 0
		i = 0
		while i < cant
			if nro1[i] == nro2[i] then
				equals += 1
			end
			i += 1
		end  
		return equals
	end


	def validation_regular
		#comparar el numero que ingreso contra el numero a adivinar y ver cuantos mal, regular y bien hay
		nro1 = "9134"
		nro2 = "1234"

		cont1 = 0
		cont2 = 0
		regular = 0

		nro1.split("").each do |n1|
			cont1 += 1	
			cont2 = 0
			nro2.split("").each do |n2|
				cont2 += 1
				if n1 == n2 then
					if cont1 == cont2 then
						puts "nro1: "+n1.to_s
						puts "nro1: "+n2.to_s
						regular += 1
					end
				end
			end
		end 
		return regular
	end
end
