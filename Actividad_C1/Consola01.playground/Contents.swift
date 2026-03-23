import UIKit

//Productos
let Cuadernos : Double = 11.80
let Mochilas : Double = 85.00
let Loncheras : Double = 42.50

//Cantidades
let cantCuadernos = 5
let cantMochilas = 4
let cantLoncheras = 10

//Importes
let importeCuadernos = Double(cantCuadernos) * Cuadernos
let importeMochilas = Double(cantMochilas) * Mochilas
let importeLoncheras = Double(cantLoncheras) * Loncheras

//Subtotal
let subtotal = importeCuadernos + importeMochilas + importeLoncheras

// Descuentos
let descuento = subtotal * 0.08
let subtotaldescuento = subtotal - descuento

let igv = subtotaldescuento * 0.18
let totalpagar = subtotaldescuento + igv

//Obsequios
let lapiceros = cantCuadernos / 2
let tomatodos = cantMochilas / 2
let tapers = cantLoncheras / 3

let totalobsequios = lapiceros + tomatodos + tapers

//Resultado

print("Importe cuadernos: \(importeCuadernos)")
print("Importe mochilas: \(importeMochilas)")
print("Importe loncheras: \(importeLoncheras)")
print("Subtotal: \(subtotal)")
print("Descuento 0.08%: \(descuento)")
print("Subtotal con descuento: \(subtotaldescuento)")
print("IGV (18%): \(igv)")
print("total a pagar: \(totalpagar)")
print("total obsequios: \(totalobsequios)")

//Nombres
let nombreCliente: String? = "Kevin"
let nombreVendedor: String? = "Oporto"

print("Nombre del cliente: \(nombreCliente!)")
print("Nombre del vendedor: \(nombreVendedor!)")
