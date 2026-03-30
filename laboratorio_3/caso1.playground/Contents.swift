let NombrePaises = ["Argentina","Bolivia","Brasil","Chile","Colombia","Ecuador","Mexico","Peru","Paraguay","Uruguay","Venezuela"]


let GDPCountryNew: [Double] = [667.922, 0.0, 2292.690 , 363.299 , 462.251 ,
 134.711 , 2030.999 , 326.608 , 51.669 ,90.640 , 79.916]


let promedioGDP = GDPCountryNew.reduce(0,+) / Double(GDPCountryNew.count)
print("Promedio \(promedioGDP)");


if let maxGDP = GDPCountryNew.max(),
   let indiceMax = GDPCountryNew.firstIndex(of: maxGDP) {
    print("El GDP más alto es \(maxGDP) y corresponde a \(NombrePaises[indiceMax])")
}


let paisesMayor300 = zip(NombrePaises, GDPCountryNew).filter { $0.1 > 300 }
print("Países con GDP mayor a 300 billones:")
for (pais, gdp) in paisesMayor300 {
    print("\(pais): \(gdp)")
}


let paisesOrdenados = zip(NombrePaises, GDPCountryNew).sorted { $0.1 < $1.1 }
print("Países ordenados por GDP:")
for (pais, gdp) in paisesOrdenados {
    print("\(pais): \(gdp)")
}
