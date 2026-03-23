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



//son 4 funciones
import Foundation

func funcion1(texto: String, numero: Int) {
    if texto.uppercased().contains("TECSUP") {
        if numero >= 1 {
            print("Pasión por la tecnología, TEC mi casita")
        } else {
            print("Cantidad de recorrido no suficiente para llegar a TECSUP")
        }
        return
    } else if texto.uppercased().contains("MIT") {
        if numero >= 2 {
            print("MIT es Tecsup premium")
        } else {
            print("Cantidad de recorrido no suficiente para llegar a MIT")
        }
        return
    } else if texto.uppercased().contains("UNI") {
        if numero >= 3 {
            funcion2(texto: texto, numero: numero)
        } else {
            print("Cantidad de recorrido no suficiente para llegar a UNI")
        }
    } else if texto.uppercased().contains("UNALM") {
        if numero >= 4 {
            funcion3(texto: texto, numero: numero)
        } else {
            print("Cantidad de recorrido no suficiente para llegar a UNALM")
        }
    } else if texto.uppercased().contains("UPM") {
        if numero >= 5 {
            funcion4(texto: texto, numero: numero)
        } else {
            print("Cantidad de recorrido no suficiente para llegar a UPM")
        }
    } else {
        print("No se encontró información de \(texto)")
    }
}

func funcion2(texto: String, numero: Int) {
    print("Esto es la UNI, los marcianos")
}

func funcion3(texto: String, numero: Int) {
    print("Esto es la UNALM aa")
}

func funcion4(texto: String, numero: Int) {
    print("Esto es la UPM")
}

// Ejemplos
funcion1(texto: "Busca UNALM", numero: 1)   
funcion1(texto: "Busca UNALM", numero: 4)
funcion1(texto: "Busca UPM", numero: 3)
funcion1(texto: "Busca UPM", numero: 5)

