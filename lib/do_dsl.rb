#!/usr/bin/env ruby

archivo = ARGV.shift 

prueba =  File.open(archivo).read
prueba = <<"PRUEBA"
  require './lib/dsl.rb'

  Dsl.new() do
    #{prueba}
  end
PRUEBA
puts eval prueba
