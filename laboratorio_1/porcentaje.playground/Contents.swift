import UIKit

var parcial1 = 15.0
var parcial2 = 18.0
var parcial3 = 16.0

var examenFinal = 17.0
var trabajoFinal = 19.0

var promedioParciales = (parcial1 + parcial2 + parcial3) / 3

var porcentajeParciales = promedioParciales * 0.55
var porcentajeExamen = examenFinal * 0.30
var porcentajeTrabajo = trabajoFinal * 0.15

var calificacionFinal = porcentajeParciales + porcentajeExamen + porcentajeTrabajo

print("Promedio de parciales: \(promedioParciales)")
print("55% de parciales: \(porcentajeParciales)")
print("30% del examen final: \(porcentajeExamen)")
print("15% del trabajo final: \(porcentajeTrabajo)")
print("Calificación final: \(calificacionFinal)")
