//
//  ContabilidadTrabajoGrupalView.swift
//  Lab_8_AM
//
//  Fórmulas de cuentas por cobrar / por pagar y ciclo financiero (documento).
//

import SwiftUI

struct ContabilidadTrabajoGrupalView: View {
    // Cuentas por cobrar
    @State private var cxcInicial: String = ""
    @State private var cxcFinal: String = ""
    @State private var ventasCredito: String = ""
    @State private var cxcVencidas: String = ""
    @State private var cxcTotales: String = ""
    @State private var pctIncobrabilidad: String = ""

    // Cuentas por pagar
    @State private var cxpInicial: String = ""
    @State private var cxpFinal: String = ""
    @State private var comprasCredito: String = ""
    @State private var pasivosTotales: String = ""

    @State private var resultados: String = ""

    var body: some View {
        Form {
            Section("Cuentas por cobrar — datos") {
                TextField("CxC saldo inicial", text: $cxcInicial)
                    .keyboardType(.decimalPad)
                TextField("CxC saldo final", text: $cxcFinal)
                    .keyboardType(.decimalPad)
                TextField("Ventas a crédito (periodo)", text: $ventasCredito)
                    .keyboardType(.decimalPad)
                TextField("CxC vencidas", text: $cxcVencidas)
                    .keyboardType(.decimalPad)
                TextField("CxC totales", text: $cxcTotales)
                    .keyboardType(.decimalPad)
                TextField("% estimado incobrabilidad (provisión)", text: $pctIncobrabilidad)
                    .keyboardType(.decimalPad)
            }

            Section("Cuentas por pagar — datos") {
                TextField("CxP saldo inicial", text: $cxpInicial)
                    .keyboardType(.decimalPad)
                TextField("CxP saldo final", text: $cxpFinal)
                    .keyboardType(.decimalPad)
                TextField("Compras a crédito (periodo)", text: $comprasCredito)
                    .keyboardType(.decimalPad)
                TextField("Pasivos totales", text: $pasivosTotales)
                    .keyboardType(.decimalPad)
            }

            Section {
                Button("Calcular indicadores") {
                    calcular()
                }
            }

            if !resultados.isEmpty {
                Section("Resultados") {
                    Text(resultados)
                        .font(.footnote)
                }
            }
        }
        .navigationTitle("Trabajo grupal")
    }

    private func calcular() {
        resultados = ""
        var lineas: [String] = []

        let cxcProm = promedio(cxcInicial, cxcFinal)
        let ventas = parse(ventasCredito)
        let venc = parse(cxcVencidas)
        let cxcTot = parse(cxcTotales)
        let pct = parse(pctIncobrabilidad)

        if let cxcProm, let ventas, ventas > 0 {
            let edadCob = (cxcProm * 360.0) / ventas
            let rotCob = ventas / cxcProm
            lineas.append(String(format: "Edad promedio CxC: %.2f días", edadCob))
            lineas.append(String(format: "Rotación CxC: %.4f", rotCob))
        }

        if let venc, let cxcTot, cxcTot > 0 {
            let morosidad = (venc / cxcTot) * 100.0
            lineas.append(String(format: "Índice de morosidad: %.2f %%", morosidad))
        }

        if let cxcTot, let pct {
            let prov = cxcTot * (pct / 100.0)
            lineas.append(String(format: "Provisión incobrables: %.2f", prov))
        }

        let cxpProm = promedio(cxpInicial, cxpFinal)
        let compras = parse(comprasCredito)

        if let cxpProm, let compras, compras > 0 {
            let edadPagar = (cxpProm * 360.0) / compras
            let rotPagar = compras / cxpProm
            lineas.append(String(format: "Edad promedio CxP: %.2f días", edadPagar))
            lineas.append(String(format: "Rotación CxP: %.4f", rotPagar))

            if let cxcProm, let ventas, ventas > 0 {
                let edadCob = (cxcProm * 360.0) / ventas
                let ciclo = edadCob - edadPagar
                lineas.append(String(format: "Ciclo financiero (Edad CxC − Edad CxP): %.2f días", ciclo))
            }
        }

        if let cxpProm, let pas = parse(pasivosTotales), pas > 0 {
            let endeud = (cxpProm / pas) * 100.0
            lineas.append(String(format: "Índice endeudamiento proveedores (CxP prom. / Pasivos × 100): %.2f %%", endeud))
        }

        resultados = lineas.isEmpty ? "Complete los datos necesarios (evite división entre cero)." : lineas.joined(separator: "\n")
    }

    private func promedio(_ a: String, _ b: String) -> Double? {
        guard let x = parse(a), let y = parse(b) else { return nil }
        return (x + y) / 2.0
    }

    private func parse(_ s: String) -> Double? {
        let t = s.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: ",", with: ".")
        guard !t.isEmpty, let v = Double(t) else { return nil }
        return v
    }
}

#Preview {
    NavigationStack {
        ContabilidadTrabajoGrupalView()
    }
}
