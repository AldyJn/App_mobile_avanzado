//
//  NotasTeoriaView.swift
//  Lab_8_AM
//
//  Cálculo de notas de teoría — TECSUP (Programación en Móviles Avanzado)
//  - 4 notas de teoría (0 a 20)
//  - Eliminar la menor para el promedio (según caso)
//  - Resultado redondeado
//  - Laboratorio AN: no se elimina la nota de laboratorio; se considera en el criterio del documento
//

import SwiftUI

struct NotasTeoriaView: View {
    @State private var n1: String = ""
    @State private var n2: String = ""
    @State private var n3: String = ""
    @State private var n4: String = ""
    @State private var notaLaboratorio: String = ""

    @State private var promedioRedondeado: Int?
    @State private var mensaje: String = ""

    var body: some View {
        Form {
            Section("Programación en Móviles Avanzado — 4 notas de teoría") {
                TextField("Nota 1 (0–20)", text: $n1)
                    .keyboardType(.decimalPad)
                TextField("Nota 2 (0–20)", text: $n2)
                    .keyboardType(.decimalPad)
                TextField("Nota 3 (0–20)", text: $n3)
                    .keyboardType(.decimalPad)
                TextField("Nota 4 (0–20)", text: $n4)
                    .keyboardType(.decimalPad)
            }

            Section("Laboratorio") {
                TextField("Nota de laboratorio (0–20) o AN", text: $notaLaboratorio)
                    .textInputAutocapitalization(.characters)
                Text("Si ingresa AN (anulado), no se elimina la nota de laboratorio del criterio: el promedio se calcula solo con las cuatro notas de teoría eliminando la menor.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            Section {
                Button("Calcular promedio") {
                    calcular()
                }
            }

            if let p = promedioRedondeado {
                Section("Resultado") {
                    Text("Promedio (redondeado): \(p)")
                        .font(.title2)
                        .fontWeight(.semibold)
                    if !mensaje.isEmpty {
                        Text(mensaje)
                            .font(.footnote)
                    }
                }
            }
        }
        .navigationTitle("Notas de teoría")
    }

    private func calcular() {
        promedioRedondeado = nil
        mensaje = ""

        guard let t1 = parseNota(n1),
              let t2 = parseNota(n2),
              let t3 = parseNota(n3),
              let t4 = parseNota(n4) else {
            mensaje = "Ingrese las cuatro notas de teoría válidas entre 0 y 20."
            return
        }

        let teoricas = [t1, t2, t3, t4]
        let labRaw = notaLaboratorio.trimmingCharacters(in: .whitespacesAndNewlines)
        let labUpper = labRaw.uppercased()

        if labUpper == "AN" {
            // No eliminar la nota de laboratorio: no entra al conjunto numérico;
            // promedio según las 4 teorías eliminando la menor (3 notas).
            let ordenadas = teoricas.sorted()
            let mejoresTres = Array(ordenadas.dropFirst())
            let prom = mejoresTres.reduce(0, +) / 3.0
            promedioRedondeado = Int(prom.rounded())
            mensaje = "Laboratorio AN: el promedio usa las tres mejores notas de teoría (se eliminó la menor solo entre teorías)."
            return
        }

        if labRaw.isEmpty {
            let ordenadas = teoricas.sorted()
            let mejoresTres = Array(ordenadas.dropFirst())
            let prom = mejoresTres.reduce(0, +) / 3.0
            promedioRedondeado = Int(prom.rounded())
            mensaje = "Solo teoría: se eliminó la menor de las cuatro notas."
            return
        }

        guard let lab = parseNota(labRaw) else {
            mensaje = "Nota de laboratorio inválida. Use un número entre 0 y 20 o AN."
            return
        }

        var todas = teoricas + [lab]
        if let minVal = todas.min(), let idx = todas.firstIndex(of: minVal) {
            todas.remove(at: idx)
        }
        let prom = todas.reduce(0, +) / Double(todas.count)
        promedioRedondeado = Int(prom.rounded())
        mensaje = "Con laboratorio numérico: se eliminó la menor entre las cinco notas."
    }

    /// Valida rango 0…20 (documento).
    private func parseNota(_ s: String) -> Double? {
        let t = s.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: ",", with: ".")
        guard let v = Double(t), v >= 0, v <= 20 else { return nil }
        return v
    }
}

#Preview {
    NavigationStack {
        NotasTeoriaView()
    }
}
