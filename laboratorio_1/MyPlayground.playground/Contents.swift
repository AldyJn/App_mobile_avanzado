import UIKit

var distancia = 50.0
var v1 = 60.0
var v2 = 90.0

var velocidadRelativa = v2 - v1

var tiempoHoras = distancia / velocidadRelativa

var tiempoMinutos = tiempoHoras * 60

print("El vehículo más rápido alcanzará al otro en \(tiempoMinutos) minutos")
