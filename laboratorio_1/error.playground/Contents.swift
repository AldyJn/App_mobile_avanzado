import UIKit

let precioActual: String = 10.0 // Error: Tipo incorrecto (String no puede almacenar un número Double)
let cantidad = "5" // Error: cantidad es String y luego se usa en operaciones numéricas
                   // Además falta eliminar el "/" que aparece al final en el código original

let nuevoPrecio = precioActual * 0.95 // Error: No se pueden hacer operaciones matemáticas con String

let importeCompra = nuevoPrecio * Double(cantidad)
// Error: cantidad es String y Double(cantidad) devuelve un Optional (Double?)
// debería convertirse correctamente antes de usar

let importeDescuento = importeCompra * 0.07 // Este depende de que importeCompra sea numérico correcto

let importeAPagar = importeCompra - importeDescuento // Correcto solo si los anteriores son Double

let obsequios = cantidad * 2 // Error: No se puede multiplicar un String por un Int

print("Nuevo precio de la gaseosa: " + nuevoPrecio)
// Error: No se puede concatenar String con Double directamente

print("Importe de la compra: " + importeCompra)
// Error: Concatenación incorrecta entre String y Double

print("Importe del descuento: " + importeDescuento)
// Error: Concatenación incorrecta entre String y Double

print("Importe a pagar: " + importeAPagar)
// Error: Concatenación incorrecta entre String y Double

print("Obsequio: " + obsequios + " caramelos")
// Error: No se puede concatenar String con Int directamente
