//
//  CalculoCTSView.swift
//  Lab_8_AM
//
//  CTS = (Sueldo + 1/6 de la gratificación) × (Meses trabajados / 12)
//

import SwiftUI

struct CalculoCTSView: View {
    @State private var sueldo: String = ""
    @State private var gratificacionAnual: String = ""
    @State private var mesesTrabajados: String = ""

    @State private var cts: Double?
    @State private var error: String = ""

    var body: some View {
        Form {
            Section("Datos") {
                TextField("Sueldo mensual", text: $sueldo)
                    .keyboardType(.decimalPad)
                TextField("Gratificación percibida en el año", text: $gratificacionAnual)
                    .keyboardType(.decimalPad)
                TextField("Meses trabajados (período semestral)", text: $mesesTrabajados)
                    .keyboardType(.decimalPad)
            }

            Section("Fórmula") {
                Text("CTS = (Sueldo + 1/6 de la gratificación) × (Meses trabajados / 12)")
                    .font(.footnote)
            }

            Section {
                Button("Calcular CTS") {
                    calcular()
                }
            }

            if let c = cts {
                Section("Resultado") {
                    Text(String(format: "CTS: S/ %.2f", c))
                        .font(.title2)
                        .fontWeight(.semibold)
                }
            }

            if !error.isEmpty {
                Section {
                    Text(error)
                        .foregroundStyle(.red)
                }
            }
        }
        .navigationTitle("CTS")
    }

    private func calcular() {
        cts = nil
        error = ""
        guard let s = parse(sueldo),
              let g = parse(gratificacionAnual),
              let m = parse(mesesTrabajados),
              m >= 0, m <= 12 else {
            error = "Verifique los valores numéricos y que los meses estén entre 0 y 12."
            return
        }
        let sextoGrat = g / 6.0
        let base = s + sextoGrat
        cts = base * (m / 12.0)
    }

    private func parse(_ s: String) -> Double? {
        let t = s.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: ",", with: ".")
        guard let v = Double(t), v >= 0 else { return nil }
        return v
    }
}

#Preview {
    NavigationStack {
        CalculoCTSView()
    }
}
