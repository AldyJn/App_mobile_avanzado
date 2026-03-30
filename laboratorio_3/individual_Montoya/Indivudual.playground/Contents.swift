let CONECTORES: [String: [String]] = [
    "to": ["a"],
    "is": ["es"],
    "a": ["un"],
    "in": ["en"],
    "are": ["estamos"]
]

let frase = "Hi, welcome to Tecsup, today is a great day!"

func traducirConectores(_ frase: String) -> String {
    let palabras = frase.split(separator: " ")
    
    let traducidas = palabras.map { palabra -> String in
        let clave = String(palabra)
        if let traduccion = CONECTORES[clave] {
            return traduccion[0]
        } else {
            return clave
        }
    }
    
    return traducidas.joined(separator: " ")
}

let resultado = traducirConectores(frase)
print(resultado)
