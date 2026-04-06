class Persona{
    var nombre: String
    var edad: Int
    
    init(nombre: String, edad: Int) {
        self.nombre = nombre
        self.edad = edad
    }
    
    func presentarse(){
        print(  "Oli soy \(nombre) y tengo \(edad) años")
    }
}

class Estudiante: Persona {
    var curso: String
    
    init(nombre: String, edad: Int, curso: String) {
        self.curso = curso
        super.init(nombre: nombre, edad: edad)
    }
    override func presentarse() {
        print(  "Oli soy el estudiante \(nombre), tengo \(edad) años y estudio \(curso)")
    }
}
class Profesor: Persona {
    var especialidad: String
    
    init(nombre: String, edad: Int, especialidad: String) {
        self.especialidad = especialidad
        super.init(nombre: nombre, edad: edad)
    }
    override func presentarse() {
        print(  "Oli soy el profesor \(nombre), tengo \(edad) años y enseño \(especialidad)")
    }

}
let persona1 = Persona(nombre: "Aldy", edad: 20)
persona1.presentarse()

let estudiante1 = Estudiante(nombre: "Fernando", edad: 18, curso: "Programación en block de notas")
estudiante1.presentarse()

let profesor1 = Profesor(nombre: "Victor", edad: 45, especialidad: "Master en Pseint")
profesor1.presentarse()
