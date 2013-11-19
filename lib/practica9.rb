require "practica9/version"

module Practica9
  # Your code goes here...
   
   class Matriz
      attr_reader :filas, :columnas

      #Inicialización de la matriz
      def initialize(elementos)
         #Se copian los elementos
         @elementos = Array.new(elementos);
         #Se calculan el número de filas y columnas
         @filas = @elementos.length
         @columnas = @elementos[0].length
         #Se comprueba que los elementos pasados se corresponden con una matriz (dimensiones correctas)
         @filas.times do |i|
            raise ArgumentError, 'Los elementos pasados no se corresponden con una matriz' unless @elementos[i].length == @columnas
         end
      end
      
      #Función para acceder al elemento i, j
      def at(i, j)
         @elementos[i][j]
      end
      
      #Sobrecarga del operador == 
      def == (other)
         @filas.times do |i|
            @columnas.times do |j|
               if @elementos[i][j] != other.at(i,j)
                  return false
               end
            end
         end
         
         return true
      end
      
      #Función para el cálculo de la traspuesta
      def traspuesta
         new_mat = Array.new
         @columnas.times do |i|
            fila = Array.new
            @filas.times do |j|
               fila << @elementos[j][i]
            end
            new_mat << fila
         end
         Matriz.new(new_mat)
      end
      
      #Sobrecarga del operador de suma
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
         Matriz.new(new_mat)
      end
      
      #Sobrecarga del operador de resta
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
         Matriz.new(new_mat)
      end
      
      def *(other)
         raise ArgumentError, "Las dimensiones de las matrices no coinciden" unless @columnas == other.filas
         new_mat = Array.new
         @filas.times do |i|
            fila = Array.new
            other.columnas.times do |j|
               sum = 0
               @columnas.times do |k|
                  sum += @elementos[i][k] * other.at(k, j)
               end
               fila << sum
            end
            new_mat << fila
         end
         Matriz.new(new_mat)
      end
      
   end
   
   class Fraccion
   include Comparable
   
      attr_reader :num, :denom
      def initialize(x,y)
         @num = x/gcd(x,y)
         @denom = y/gcd(x,y)
      end
      def to_s
         "#{@num}/#{@denom}"
      end
      def to_float
         @num/@denom
      end
   
      def abs
         @num.abs/@denom.abs
      end
      def reciprocal
            Fraccion.new(@denom,@num)
      end
      
      def + (other)
         _num = 0
         _denom = 1
         if other.is_a? Fraccion
            #Se calculan los nuevos valores
            _num = @num*other.denom + @denom*other.num
            _denom = @denom*other.denom
         elsif other.respond_to? :+ && other.respond_to? :*
            _num = @num + @denom*other
            _denom = @denom
         end
      
         return Fraccion.new(_num,_denom)
      end
      
      def - (other = Fraccion.new(@num*2,@denom))
         #Se calculan los nuevos valores
         num = @num*other.denom - @denom*other.num
         denom = @denom*other.denom
      
         return Fraccion.new(num,denom)
      end
      
      def * (other)
         #Se calculan los nuevos valores
         num = @num*other.num
         denom = @denom*other.denom
      
         return Fraccion.new(num,denom)
      end
      
      def / (other) 
         num = @num*other.denom
         denom = @denom*other.num
         
         return Fraccion.new(num,denom)
      end
      
      def % (other) 
         num = @num*other.denom
         denom = @denom*other.num
         
         return Fraccion.new(num % denom,1)
      end
      
      def <=> (other)
      if ((num/denom) < (other.num/other.denom))
         return -1
      end
      if ((num/denom) == (other.num/other.denom))
         return 0
      end
      if ((num/denom) > (other.num/other.denom))
         return 1
      end
      end
      
   end


   def gcd(u, v)
      u, v = u.abs, v.abs
      
      while v != 0 
         u, v = v, u % v
      end
      u
   end
   
end
