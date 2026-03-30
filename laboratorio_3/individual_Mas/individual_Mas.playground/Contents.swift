import Foundation
let bancoPalabras: [String: String] = [
    "we": "nosotros",
    "learning": "aprendiendo",
    "learn": "aprender",
    "swift": "Swift",
    "tecsup": "Tecsup",
    "welcome": "bienvenido",
    "class": "clase"
]


let conectores = ["in", "to", "are", "a", "is"]



func eliminarConectores(palabras: [String]) -> [String] {
    var resultado: [String] = []

    for palabra in palabras {
        var esConector = false

        for conector in conectores {
            if palabra.lowercased() == conector {
                esConector = true
            }
        }

        if esConector == false {
            resultado.append(palabra)
        }
    }

    return resultado
}



func traducir(palabras: [String]) -> [String] {
    var resultado: [String] = []

    for palabra in palabras {
        let clave = palabra.lowercased()

        if bancoPalabras[clave] != nil {
            resultado.append(bancoPalabras[clave]!)
        } else {
            resultado.append("No se encuentra traduccion")
        }
    }

    return resultado
}



func Traductor(_ frase: String) {

    let palabras = frase.components(separatedBy: " ")

    let sinConectores = eliminarConectores(palabras: palabras)
    let traducido = traducir(palabras: sinConectores)

    print("Sin conectores:")
    print(sinConectores.joined(separator: " "))

    print("\nTraducción:")
    print(traducido.joined(separator: ", "))
}


// TEST
Traductor("Tecsup in class")
