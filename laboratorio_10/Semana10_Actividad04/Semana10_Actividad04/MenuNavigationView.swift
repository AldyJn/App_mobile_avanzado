//
//  MenuNavigationView.swift
//  Semana10_Actividad04 — Actividad 04 (GLAB-S10)
//

import SwiftUI

struct MenuNavigationView: View {
    var onVista1: () -> Void
    var onVista2: () -> Void
    var onVista3: () -> Void

    var body: some View {
        VStack(spacing: 32) {
            Text("Menú principal")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("SwiftUI Menu integrado en UIKit")
                .foregroundStyle(.secondary)

            Menu {
                Button("Vista 1 — Suma simple") {
                    onVista1()
                }
                Button("Vista 2 — Interés compuesto") {
                    onVista2()
                }
                Button("Vista 3 — Simulador de préstamo") {
                    onVista3()
                }
            } label: {
                Label("Abrir menú de navegación", systemImage: "line.3.horizontal")
                    .font(.title3)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 14)
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
    }
}
