import Cocoa

let peso = 70.0
let actividad = "reposo"

let tiempo = 180


if actividad != "dormir" && actividad != "reposo"{
    
    print("Error, Actividad invalida. Solo se permite dormir o reposo")
} else {
    
    var CaloriasPorMinuto = 0.0
    
    if actividad == "dormir"{
        CaloriasPorMinuto = 0.08
    } else if actividad == "reposo"{
        CaloriasPorMinuto = 1.66
    }
    
    let calorias = CaloriasPorMinuto * Double(tiempo)
    print("Actividad", actividad)
    print("Tiempo,", tiempo, "minutos")
    print("Calorias consumida:", calorias)
}
