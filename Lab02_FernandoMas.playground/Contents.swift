//Caso 01
/*import Foundation

let Capital_inicial : Double = 50000
let TasaInteres: Double = 0.08
let InteresMinimo: Double = 7000.0

let InteresGenerado = TasaInteres * Capital_inicial
var CapitalFinal : Double

if InteresGenerado > InteresMinimo {
    CapitalFinal = Capital_inicial + InteresGenerado
    print("Intereses generados : $\(InteresGenerado)")
    print("Los intereses superan: $\(InteresMinimo)")
    print("Capital final en la cuenta: $\(CapitalFinal)")
} else {
    CapitalFinal = Capital_inicial
    print("Intereses generados : $\(InteresGenerado)")
    print("Los intereses no superan: $\(InteresMinimo). No se revierten")
    print("Capital final en la cuenta: $\(CapitalFinal)")
}
*/


//Caso 4
let PrecioUnitario: Double = 50.0
let Cantidad: Double = 4.0
let Subtotal = PrecioUnitario * Cantidad
let Dsct : Double = 0.10
let MontoDescuento = Subtotal * Dsct
let PagoTotal = Subtotal - MontoDescuento


print("El subtotal es: $\(Subtotal)")
print("El MontoDescuento es: $\(MontoDescuento)")
print("El pago total es: $\(PagoTotal)")



//son 4 funciones, 
