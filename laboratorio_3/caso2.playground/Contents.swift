let INCAS: Set<String> = [
        "Manco Cápac",
        "Sinchi Roca",
        "Lloque Yupanqui",
        "Mayta Cápac",
        "Cápac Yupanqui",
        "Inca Roca",
        "Yahuar Huácac",
        "Huiracocha",
        "Pachacútec Inca Yupanqui",
        "Amaru Inca Yupanqui",
        "Túpac Inca Yupanqui",
        "Huayna Cápac",
        "Huáscar",
        "Atahualpa"
]
let buscar = "Pachacútec Inca Yupanqui"

if INCAS.contains(buscar) {
    print("\(buscar) está en la cronología")
} else {
    print("\(buscar) NO está en la cronología")
}

let otrosIncas: Set = ["Fernando Mas", "Aldy Montoya"]

let union = INCAS.union(otrosIncas)

print(union)
let yupanquis = INCAS.filter { $0.contains("Yupanqui") }

print(yupanquis)
