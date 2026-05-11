//
//  PagoInstructorView.swift
//  Lab_8_AM
//
//  Pago por hora: S/ 50. Horas semanales máximas: 23.
//  Sueldo bruto = Horas semanales × pago por hora × 4
//  Sueldo neto = Sueldo bruto − (AFP/ONP + IR). ESSALUD 9% solo empleador (no descuenta al instructor).
//

import SwiftUI

struct PagoInstructorView: View {
    @State private var horasSemanales: String = ""
    @State private var porcentajeAFP: String = "10"
    @State private var aplicaIR: Bool = false
    @State private var porcentajeIR: String = "5"

    @State private var bruto: Double?
    @State private var afpMonto: Double?
    @State private var irMonto: Double?
    @State private var neto: Double?
    @State private var advertencia: String = ""

    private let pagoPorHora: Double = 50
    private let horasMaximas: Double = 23

    var body: some View {
        Form {
            Section("Ingresos") {
                TextField("Horas semanales (máx. 23)", text: $horasSemanales)
                    .keyboardType(.decimalPad)
                Text("Pago por hora: S/ \(Int(pagoPorHora))")
                Text("Sueldo bruto mensual = Horas × \(Int(pagoPorHora)) × 4")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            Section("Descuentos al instructor") {
                TextField("AFP u ONP (% del bruto, típico 10–13)", text: $porcentajeAFP)
                    .keyboardType(.decimalPad)
                Toggle("Aplicar impuesto a la renta (IR) proporcional", isOn: $aplicaIR)
                if aplicaIR {
                    TextField("IR (% orientativo sobre bruto)", text: $porcentajeIR)
                        .keyboardType(.decimalPad)
                }
                Text("ESSALUD 9%: aporte empleador; no se resta del sueldo neto del instructor (según documento).")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            Section {
                Button("Calcular sueldos") {
                    calcular()
                }
            }

            if let b = bruto, let n = neto {
                Section("Resultados") {
                    Text(String(format: "Sueldo bruto: S/ %.2f", b))
                    if let a = afpMonto {
                        Text(String(format: "AFP/ONP: S/ %.2f", a))
                    }
                    if let i = irMonto {
                        Text(String(format: "IR: S/ %.2f", i))
                    }
                    Text(String(format: "Sueldo neto: S/ %.2f", n))
                        .font(.title2)
                        .fontWeight(.semibold)
                }
            }

            if !advertencia.isEmpty {
                Section {
                    Text(advertencia)
                        .foregroundStyle(.orange)
                }
            }
        }
        .navigationTitle("Pago instructores")
    }

    private func calcular() {
        bruto = nil
        afpMonto = nil
        irMonto = nil
        neto = nil
        advertencia = ""

        guard let hRaw = parse(horasSemanales) else {
            advertencia = "Ingrese horas semanales válidas."
            return
        }
        let h = min(max(hRaw, 0), horasMaximas)
        if hRaw > horasMaximas {
            advertencia = "Las horas semanales no deben superar 23; se usó 23 para el cálculo."
        }

        let b = h * pagoPorHora * 4.0
        bruto = b

        let pAfp = min(max(parse(porcentajeAFP) ?? 10, 0), 100) / 100.0
        let montoAfp = b * pAfp
        afpMonto = montoAfp

        var montoIr = 0.0
        if aplicaIR {
            let pIr = min(max(parse(porcentajeIR) ?? 0, 0), 100) / 100.0
            montoIr = b * pIr
            irMonto = montoIr
        } else {
            irMonto = nil
        }

        neto = b - montoAfp - montoIr
    }

    private func parse(_ s: String) -> Double? {
        let t = s.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: ",", with: ".")
        guard let v = Double(t) else { return nil }
        return v
    }
}

#Preview {
    NavigationStack {
        PagoInstructorView()
    }
}
