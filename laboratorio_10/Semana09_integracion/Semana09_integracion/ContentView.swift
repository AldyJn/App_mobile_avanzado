//
//  ContentView.swift
//  Semana09_integracion — Actividades 01–04 (GLAB-S10)
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("UIKit → SwiftUI") {
                    NavigationLink {
                        Actividad01Screen()
                    } label: {
                        Label("Actividad 01 — UIKit en SwiftUI", systemImage: "rectangle.stack.fill")
                    }

                    NavigationLink {
                        Actividad02Screen()
                    } label: {
                        Label("Actividad 02 — Mapa MapKit", systemImage: "map.fill")
                    }
                }

                Section("SwiftUI → UIKit") {
                    NavigationLink {
                        Actividad03Screen()
                    } label: {
                        Label("Actividad 03 — UIHostingController", systemImage: "swift")
                    }

                    NavigationLink {
                        Actividad04Screen()
                    } label: {
                        Label("Actividad 04 — Menú y calculadoras", systemImage: "list.bullet")
                    }
                }
            }
            .navigationTitle("Laboratorio 10")
        }
    }
}

private struct Actividad01Screen: View {
    var body: some View {
        MiViewControllerRepresentable()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Actividad 01")
            .navigationBarTitleDisplayMode(.inline)
    }
}

private struct Actividad02Screen: View {
    var body: some View {
        MiMapaRepresentable()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Actividad 02")
            .navigationBarTitleDisplayMode(.inline)
    }
}

private struct Actividad03Screen: View {
    var body: some View {
        Actividad03Representable()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Actividad 03")
            .navigationBarTitleDisplayMode(.inline)
    }
}

private struct Actividad04Screen: View {
    var body: some View {
        Actividad04Representable()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Actividad 04")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ContentView()
}
