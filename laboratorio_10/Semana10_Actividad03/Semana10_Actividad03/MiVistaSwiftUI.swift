//
//  MiVistaSwiftUI.swift
//  Semana10_Actividad03 — Actividad 03 (GLAB-S10)
//

import SwiftUI

struct MiVistaSwiftUI: View {
    @State private var modoActivo = false

    var body: some View {
        VStack(spacing: 24) {
            Text("Vista SwiftUI en UIKit")
                .font(.title2)
                .fontWeight(.semibold)

            Text("UIHostingController convierte esta vista en UIViewController")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            Toggle("Modo activo", isOn: $modoActivo)

            Button("Mostrar estado") {
                print("Toggle activo:", modoActivo)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    MiVistaSwiftUI()
}
