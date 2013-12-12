require './lib/practica9.rb'
include  Practica9

class Dsl

   Densa = "Densa"
   Dispersa = "Dispersa"
   attr_accessor :cont

   def initialize(name = "", &block)
      @cont = 0
      @valor = ""
      instance_eval &block
      
   end
   def operacion(tipo,lista)
      vector = Array.new
      matrices = lista.each {|key, value| vector << matriz(key,value)}
      tmp = vector.pop()
      case tipo
      when "suma"
         valor = vector.each{|x| tmp = x + tmp}
      when "resta"
         valor = vector.each{|x| tmp = x - tmp}
      when "multipliacion"
         valor = vector.each{|x| tmp = x * tmp}
      end
      @valor  << tipo  << "\n" << tmp.to_s.to_s << "\n"
   end
   def densa(f,c)
      @cont = @cont + 1;
      [@cont,"Densa",f,c]
   end
   def dispersa(f,c)
      @cont = @cont + 1;
      [@cont,"Dispersa",f,c]
   end
   def matriz(tipo,valor)
      if tipo[1] == "Densa"
         return MatrizDensa.new(tipo[2],tipo[3],valor)
      end
      if tipo[1] == "Dispersa"
         return MatrizDispersa.new(tipo[2],tipo[3],valor)
      end
   end
   def to_s
      @valor
   end
end
