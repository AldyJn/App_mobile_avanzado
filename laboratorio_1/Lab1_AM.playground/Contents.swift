//: Playground - noun: a place where people can play

import UIKit

let hola:String = "Mi primer playground "
let hola2 = "Sus Nombres"
let regalo:String = "3"

let a:Double = 10.1
let b:Double = 2.5
let c:Int = 10
let d:Int = 2

let e:Character = "X"
let f:Bool = true

let suma = a + b
let resta = c - d
let division = a / Double(c)

var multiplicacion = b * Double(c)

let validaSuma = e == "X" ? suma : Double(resta)

multiplicacion = 12.5

let saludo = hola + hola2 + " su nota es \(suma) "
print(saludo)

let bono = Double(regalo) ?? 0

let extras = saludo + " + bono de \(bono) es \(suma + bono)"
print(extras)
