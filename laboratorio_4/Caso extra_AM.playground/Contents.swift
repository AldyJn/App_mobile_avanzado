enum Paises {
    case Rusia
    case USA
    case China
}

class Tripulante {
    var nombre : String
    var apellido : String
    var edad : Int
    var nacionalidad : String
    var especialidad : String
    
    init(nombre: String, apellido: String, edad: Int, nacionalidad: String, especialidad: String) {
        self.nombre = nombre
        self.apellido = apellido
        self.edad = edad
        self.nacionalidad = nacionalidad
        self.especialidad = especialidad
    }
}

class NaveEspacial {
    var nombre: String
    var pais : Paises

    init(nombre: String, pais: Paises) {
        self.nombre = nombre
        self.pais = pais
    }
    func obtenerInformacion() -> String {
            return "Nave: \(nombre) - País: \(pais)"
        }
}

protocol ServiciosVitales {
    
    func estadoServiciosHigienicos() -> Bool
    func estadoCocina() -> Bool
}
 
class NaveEspacialLuna{
    
}

class NaveEspacialMarte:NaveEspacial , ServiciosVitales {

    var tripulantes : [Tripulante]

    init(nombre: String, pais: Paises , tripulantes: [Tripulante]) {
        self.tripulantes = tripulantes
        super.init(nombre: nombre , pais:pais)
    }
    
    func estadoServiciosHigienicos()  -> Bool{
        return true
    }

    func estadoCocina()  -> Bool {
        return true
    }
    func obtenerInformacionViaje() {
            print("Nave: \(nombre)")
            print("País: \(pais)")
            print("Tripulación:")
            
            for t in tripulantes {
                print("\(t.nombre) \(t.apellido) - \(t.especialidad)")
            }
        }
}
let t1 = Tripulante(nombre: "Aldy", apellido: "Lopez", edad: 30, nacionalidad: "Peruano", especialidad: "Ingeniera")
let t2 = Tripulante(nombre: "Jenxy", apellido: "Perez", edad: 35, nacionalidad: "Mexicano", especialidad: "Piloto")

let naveMarte = NaveEspacialMarte(
    nombre: "MarsX",
    pais: .USA,
    tripulantes: [t1, t2]
)

naveMarte.obtenerInformacionViaje()

print("Baños:", naveMarte.estadoServiciosHigienicos())
print("Cocina:", naveMarte.estadoCocina())
