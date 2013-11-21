require "./lib/practica9/version"

module Practica9
   class Matriz
      attr_accessor :filas, :columnas, :elementos
      def initialize (filas, columnas, elementos)
         @filas = filas
         @columnas = columnas
         @elementos = elementos
      end
      
      def at(i, j) end
           
      def to_s
         tmp = ""
         @filas.times do |i|
            @columnas.times do |j|
               tmp << "#{at(i, j)} "
            end
            tmp << "\n"
         end
         tmp
      end
   end

   class MatrizDensa < Matriz
      def initialize (filas, columnas, elementos)
         super(filas, columnas, elementos)
      end

      def [](i)
         @elementos[i]
      end

      def at(i,j)
          @elementos[i][j]
      end
      
      def traspuesta
         new_mat = Array.new
         @columnas.times do |i|
            fila = Array.new
            @filas.times do |j|
               fila << @elementos[j][i]
            end
            new_mat << fila
         end
         MatrizDensa.new(@columnas, @filas, new_mat)
      end
      
   #Sobrecarga del operador == 
   def == (other)
      @filas.times do |i|
         @columnas.times do |j|
            if at(i, j) != other.at(i,j)
               return false
            end
         end
      end
      
      return true
   end

      def +(other)
         raise ArgumentError, "Las dimensiones de las matrices no coinciden" unless @filas == other.filas && @columnas == other.columnas
         new_mat = Array.new
         @filas.times do |i|
            fila = Array.new
            @columnas.times do |j|
               fila << @elementos[i][j] + other.at(i, j)
            end
            new_mat << fila
         end
         MatrizDensa.new(@filas, @columnas,new_mat)
      end

      def -(other)
         raise ArgumentError, "Las dimensiones de las matrices no coinciden" unless @filas == other.filas && @columnas == other.columnas
         new_mat = Array.new
         @filas.times do |i|
            fila = Array.new
            @columnas.times do |j|
               fila << @elementos[i][j] - other.at(i, j)
            end
            new_mat << fila
         end
         MatrizDensa.new(@filas, @columnas,new_mat)
      end

      def *(other)
         raise ArgumentError, "Las dimensiones de las matrices no coinciden" unless @columnas == other.filas
         new_mat = Array.new
         @filas.times do |i|
            fila = Array.new
            other.columnas.times do |j|
               sum = 0
               @columnas.times do |k|
                  sum = at(i, k) * other.at(k,j) + sum
               end
               fila << sum
            end
            new_mat << fila
         end
         MatrizDensa.new(@filas, other.columnas, new_mat)
      end

      def maximo
         mayor = @elementos[0][0]
         @columnas.times do |i|
            @filas.times do |j|
               mayor = @elementos[i][j] if @elementos[i][j] > mayor
            end
         end
         mayor
      end
      
      def minimo
         menor = @elementos[0][0]
         @columnas.times do |i|
            @filas.times do |j|
               menor = @elementos[i][j] if @elementos[i][j] < menor
            end
         end
         menor
      end
      
   end

   class MatrizDispersa < Matriz
      def initialize (filas, columnas, elementos)
         super(filas, columnas, elementos)
      end

      def [](i)
         @elementos[i]
      end
      
      def at(i,j)
         #Extrae el valor del elemento i, si no existe obtiene un 0
         tmp = @elementos.fetch(i,0)
         if tmp != 0    #Si el valor obtenido no es 0, se extrae el valor del elemento j, si no existe obtiene un 0
            tmp.fetch(j,0)
         else
            0
         end
      end
      
      def traspuesta
         new_mat = Hash.new(Hash.new())
         @elementos.each do |clave, valor|
            valor.each do |clave2, valor2|
               new_mat.merge!({clave2 => {clave => valor2}}) do |clave3, oldval, newval|
                  oldval.merge!(newval)
               end
            end
         end
         MatrizDispersa.new(@columnas, @filas, new_mat)
      end
      
      def +(other)
         raise ArgumentError, "Las dimensiones de las matrices no coinciden" unless @filas == other.filas && @columnas == other.columnas
         if other.class == MatrizDensa
            other.+(self)
         elsif other.class == MatrizDispersa
            new_mat = @elementos.merge(other.elementos) do |clave, oldval, newval| 
               oldval.merge(newval) do |clave2, oldval2, newval2|
                  oldval2 + newval2
               end
            end
            MatrizDispersa.new(@filas, @columnas, new_mat)
         else
            raise TypeError.new("No se puede coaccionar #{other.inspect} a Matriz")
         end
      end

      def -(other)
         raise ArgumentError, "Las dimensiones de las matrices no coinciden" unless @filas == other.filas && @columnas == other.columnas
         if other.class == MatrizDensa
            new_mat = Array.new
            @filas.times do |i|
               fila = Array.new
               @columnas.times do |j|
                  fila << at(i, j) - other.elementos[i][j]
               end
               new_mat << fila
            end
            MatrizDensa.new(@filas, @columnas, new_mat)
         elsif other.class == MatrizDispersa
            new_mat = @elementos.merge(other.elementos) do |clave, oldval, newval| 
               oldval.merge(newval) do |clave2, oldval2, newval2|
                  oldval2 - newval2
               end
            end
            MatrizDispersa.new(@filas, @columnas, new_mat)
         else
            raise TypeError.new("No se puede coaccionar #{other.inspect} a Matriz")
         end
      end

      def *(other)
         raise ArgumentError, "Las dimensiones de las matrices no coinciden" unless @columnas == other.filas
         if other.class == MatrizDensa
            new_mat = Array.new
            @filas.times do |i|
               fila = Array.new
               other.columnas.times do |j|
                  sum = 0
                  @columnas.times do |k|
                     sum = at(i,k) * other.elementos[k][j] + sum
                  end
                  fila << sum
               end
               new_mat << fila
            end
            MatrizDensa.new(@filas, other.columnas, new_mat)
         elsif other.class == MatrizDispersa
            other = other.traspuesta
            new_mat = Hash.new(Hash.new())
            @elementos.each do |key, value|
               other.elementos.each do |key1, value1|
                  suma = 0
                  value.each do |key2, value2|
                     if(value1[key2] != nil)
                           suma +=  value2 * value1[key2]
                     end
                  end
                  if(suma != 0)
                     new_mat.merge!({{key1 => suma} => hash}) do |key3, oldval, newval|
                        oldval.merge!(newval)
                     end
                  end
               end
            end
            MatrizDispersa.new(@filas, other.columnas, new_mat)
         else
            raise TypeError.new("No se puede coaccionar #{other.inspect} a Matriz")
         end      
      end

      def maximo
         tmp = @elementos.claves
         tmp1 = tmp[0]
         tmp2 = @elementos[tmp1].valors
         mayor = tmp2[0]
         @elementos.each do |clave, valor|
            valor.each do |clave2, valor2|
               if at(clave,clave2) > mayor
                  mayor = at(clave,clave2)
               end
            end
         end
         mayor
      end
      
      def minimo
         tmp = @elementos.claves
         tmp1 = tmp[0]
         tmp2 = @elementos[tmp1].valors
         menor = tmp2[0]
         @elementos.each do |clave, valor|
            valor.each do |clave2, valor2|
               if at(clave,clave2) < menor
                  menor = at(clave,clave2)
               end
            end
         end
         menor
      end
      
   end
end

class Fraccion
   attr_reader :num, :denom 
   include Comparable
   
   def initialize(num, denom)
      mcd = gcd(num,denom)
      @num , @denom = num/mcd, denom/mcd
   end
   
   def to_s
      "#{@num}/#{@denom}"
   end
   
   def to_float()
      @num.to_float/@denom
   end
    
   def abs()
      @num.abs/@denom.abs                 
   end
    
   def reciprocal()
      Fraccion.new(@denom, @num)
   end

   def +(other)
      if other.class == Fraccion
         Fraccion.new(@num*other.denom + other.num*@denom , @denom*other.denom)
      else
         Fraccion.new(@num + other*@denom , @denom)
      end
   end

   def -(other)
      if other.class == Fraccion
         Fraccion.new(@num*other.denom - other.num*@denom , @denom*other.denom)
      else
         Fraccion.new(@num - other*@denom , @denom)
      end
   end

   def *(other)
      if other.class == Fraccion
         Fraccion.new(@num * other.num, @denom * other.denom)
      else
         Fraccion.new(@num * other, @denom)
      end
   end

   def /(other)
      Fraccion.new(@num * other.denom, @denom * other.num)
   end

   def %(other)
      result = self./(other)
      result = (result.num%result.denom).to_i
   end

   def <=>(other)
      @num.to_float/@denom <=> other.num.to_float/other.denom
   end
   
   def coerce(other)
      [self,other]
   end
end

def gcd(u, v)
  u, v = u.abs, v.abs
  while v != 0
    u, v = v, u % v
  end
  u
end

if __FILE__ == $0
# Trabajo con la clase:
include Practica9
   m1=MatrizDensa.new(2,2,[[3,4],[5,6]])
   m2=MatrizDispersa.new(2,2,{1=>{0=>Fraccion.new(1,2)}})
   
   puts "m1"
   puts m1.to_s
   puts
   puts "m2"
   puts m2.to_s
   puts
   puts "m1+m2"
   puts (m1+m2).to_s
   
end
