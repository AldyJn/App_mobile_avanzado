import Foundation

func calcularCalorias(actividad: String, minutos: Int) -> Double {
    var caloriasPorMinuto: Double = 0.0
    
    if actividad == "dormir" {
        caloriasPorMinuto = 1.08
    } else if actividad == "sentado" {
        caloriasPorMinuto = 1.66
    } else {
        print("Actividad no permitida: \(actividad)")
        return 0
    }
    
    return Double(minutos) * caloriasPorMinuto
}


func mostrarCalorias(actividad: String, minutos: Int) {
    let calorias = calcularCalorias(actividad: actividad, minutos: minutos)
    print("Calorías consumidas durante \(minutos) minutos de \(actividad): \(String(format: "%.2f", calorias)) kcal")
}
mostrarCalorias(actividad: "sentado", minutos: 123)
