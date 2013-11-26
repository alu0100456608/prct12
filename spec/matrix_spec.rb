require "./lib/practica9.rb"
include Practica9

describe "Matriz" do
   before :each do
      @f1 = MatrizDensa.new(3,2,[[1,2],[3,4],[5,6]])
      @f2 = MatrizDispersa.new(10,10,{0=>{1 => 5, 3=>6}})
      @f3 = MatrizDensa.new(10,10,[[0,1,2,3,4,5,6,7,8,9],
				  [0,1,2,3,4,5,6,7,8,9],
				  [0,1,2,3,4,5,6,7,8,9],
				  [0,1,2,3,4,5,6,7,8,9],
				  [0,1,2,3,4,5,6,7,8,9],
				  [0,1,2,3,4,5,6,7,8,9],
				  [0,1,2,3,4,5,6,7,8,9],
				  [0,1,2,3,4,5,6,7,8,9],
                                  [0,1,2,3,4,5,6,7,8,9],
				  [0,1,2,3,4,5,6,7,8,9]])
      
   end
   
   describe "Almacenamiento de numero de filas y columnas para matrices densas" do
      it "El numero de filas es correcto" do
         @f1.filas.should eq(3)
      end
      it "El numero de columnas es correcto" do
         @f1.columnas.should eq(2)
      end
   end
   
   describe "Igualdad entre matrices densas " do
      it "Las matrices han de ser iguales" do
      f = MatrizDensa.new(3,2,[[1,2],[3,4],[5,6]])
      (@f1 == f).should be_true;
      end
   end
   
   describe "Transformacion de una matriz" do
      it "MatrizDensa traspuesta" do
      f = MatrizDensa.new(2,3,[[1,3,5],[2,4,6]])
      (@f1.traspuesta == f).should be_true;
      end
   end

   describe "Operaciones con dos matrices densas" do
      it "La suma de matrices se realiza correctamente" do
         f = MatrizDensa.new(3,2,[[1,1],[2,2],[3,3]])
         (@f1 + f).should eq (MatrizDensa.new(3,2,[[2,3],[5,6],[8,9]]))
         end
         
         it "La resta de matrices se realiza correctamente" do
         f = MatrizDensa.new(3,2,[[1,1],[2,2],[3,3]])
         (@f1 - f).should eq (MatrizDensa.new(3,2,[[0,1],[1,2],[2,3]]))
         end
         it "El producto de matrices se realiza correctamente" do
         a = MatrizDensa.new(3,3,[[2,0,1],[3,0,0],[5,1,1]])
         b = MatrizDensa.new(3,3,[[1,0,1],[1,2,1],[1,1,0]])
         (a * b).should eq (MatrizDensa.new(3,3,[[3,1,2],[3,0,3],[7,3,6]]))
      end
   end
   describe "Maximo y minimo de una matriz densa" do
      it"El maximo de una matriz densa se realiza correctamente" do
        @f1.maximo.should eq (6)
      end
      it"El minimo de una matriz densa se realiza correctamente" do
        @f1.minimo.should eq (1)
      end
    end
################################################################
    ### Expectativas para Matrices Dispersas 
################################################################
   describe "Almacenamiento de numero de filas y columnas para matrices dispersas" do
      it "El numero de filas es correcto" do
         @f2.filas.should eq(10)
      end
      it "El numero de columnas es correcto" do
         @f2.columnas.should eq(10)
      end
   end
   
   describe "Igualdad entre matrices dispersas " do
      it "Las matrices han de ser iguales" do
      f = MatrizDispersa.new(10,10,{0=>{1=>5, 3=>6}})
      (@f2 == f).should be_true;
      end
   end
   
   describe "Transformacion de una matriz dispersa" do
      it "Matriz dispersa traspuesta" do
	f = MatrizDispersa.new(10,10, {1=>{0=>5}, 3=>{0=>6}})
      (@f2.traspuesta == f).should be_true;
      end
   end

   describe "Operaciones con dos matrices dispersas" do
      it "La suma de matrices se realiza correctamente" do
         f = MatrizDispersa.new(10,10, {0=>{1=>2,5=>6}, 4=>{5=>2}})
         (@f2 + f).should eq (MatrizDispersa.new(10, 10, {0=>{1=>7,3=>6,5=>6},4=>{5=>2}}))
         end
         
         it "La resta de matrices dispersas se realiza correctamente" do
         f = MatrizDispersa.new(10,10, {0=>{1=>2,5=>6}, 4=>{5=>2}})
	 (@f2 - f).should eq (MatrizDispersa.new(10, 10, {0=>{1=>3,3=>6,5=>-6},4=>{5=>-2}}))
         end
         it "El producto de matrices dispersas se realiza correctamente" do
         f = MatrizDispersa.new(10,10, {0=>{1=>2,5=>6}, 4=>{5=>2}})
         (@f2 * f).should eq (MatrizDispersa.new(10,10,{}))
      end
   end
   describe "Maximo y minimo de una matriz dispersa" do
      it"El maximo de una matriz dispersa se realiza correctamente" do
        @f2.maximo.should eq (6)
      end
      it"El minimo de una matriz dispersa se realiza correctamente" do
        @f2.minimo.should eq (5)
      end
    end
#####################################################################
    describe "Operaciones entre matrices densas y dispersas" do
      it "Suma de una matriz densa mas una dispersa" do
	(@f3 + @f2).should eq (MatrizDensa.new(10,10,[[0,6,2,9,4,5,6,7,8,9],
				  [0,1,2,3,4,5,6,7,8,9],
				  [0,1,2,3,4,5,6,7,8,9],
				  [0,1,2,3,4,5,6,7,8,9],
				  [0,1,2,3,4,5,6,7,8,9],
				  [0,1,2,3,4,5,6,7,8,9],
				  [0,1,2,3,4,5,6,7,8,9],
				  [0,1,2,3,4,5,6,7,8,9],
	                          [0,1,2,3,4,5,6,7,8,9],
				  [0,1,2,3,4,5,6,7,8,9]]))
	end
       it "Suma de una matriz dispersa mas una densa" do
	(@f2 + @f3).should eq (MatrizDensa.new(10,10,[[0,6,2,9,4,5,6,7,8,9],
				  [0,1,2,3,4,5,6,7,8,9],
				  [0,1,2,3,4,5,6,7,8,9],
				  [0,1,2,3,4,5,6,7,8,9],
				  [0,1,2,3,4,5,6,7,8,9],
				  [0,1,2,3,4,5,6,7,8,9],
				  [0,1,2,3,4,5,6,7,8,9],
				  [0,1,2,3,4,5,6,7,8,9],
	                          [0,1,2,3,4,5,6,7,8,9],
				  [0,1,2,3,4,5,6,7,8,9]]))
	end
	it "Resta de una matriz densa menos una dispersa" do
	(@f3 - @f2).should eq (MatrizDensa.new(10,10,[[0,-4,2,-3,4,5,6,7,8,9],
				  [0,1,2,3,4,5,6,7,8,9],
				  [0,1,2,3,4,5,6,7,8,9],
				  [0,1,2,3,4,5,6,7,8,9],
				  [0,1,2,3,4,5,6,7,8,9],
				  [0,1,2,3,4,5,6,7,8,9],
				  [0,1,2,3,4,5,6,7,8,9],
				  [0,1,2,3,4,5,6,7,8,9],
	                          [0,1,2,3,4,5,6,7,8,9],                    
				  [0,1,2,3,4,5,6,7,8,9]]))
	end
       it "Resta de una matriz dispersa menos una densa" do
	(@f2 - @f3).should eq (MatrizDensa.new(10,10,[[0,4,-2,3,-4,-5,-6,-7,-8,-9],
				  [0,-1,-2,-3,-4,-5,-6,-7,-8,-9],
				  [0,-1,-2,-3,-4,-5,-6,-7,-8,-9],
				  [0,-1,-2,-3,-4,-5,-6,-7,-8,-9],
				  [0,-1,-2,-3,-4,-5,-6,-7,-8,-9],
				  [0,-1,-2,-3,-4,-5,-6,-7,-8,-9],
				  [0,-1,-2,-3,-4,-5,-6,-7,-8,-9],
				  [0,-1,-2,-3,-4,-5,-6,-7,-8,-9],
				  [0,-1,-2,-3,-4,-5,-6,-7,-8,-9],
				  [0,-1,-2,-3,-4,-5,-6,-7,-8,-9]]))
	                                              
	end
	it "Multiplicacion de una matriz densa por una dispersa" do
	 f = MatrizDensa.new(3,3,[[2,4,5],[7,6,1],[2,4,6]])
	 k = MatrizDispersa.new(3,3,{0=>{2=>3}})                    
	 (f*k).should eq(MatrizDensa.new(3,3,[[0,0,6],[0,0,21],[0,0,6]]))              
	end
	it "Multiplicacion de una matriz dispersa por una densa" do
	 f = MatrizDensa.new(3,3,[[2,4,5],[7,6,1],[2,4,6]])
	 k = MatrizDispersa.new(3,3,{0=>{2=>3}})                    
	 (k*f).should eq(MatrizDensa.new(3,3,[[6,12,18],[0,0,0],[0,0,0]]))      
	end                      
    end
end
                              
