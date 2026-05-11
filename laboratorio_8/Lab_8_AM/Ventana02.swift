//
//  Ventana02.swift
//  Lab_8_AM
//
//  Actividad: combinar HStack, VStack y ZStack
//

import SwiftUI

struct Ventana02: View {
    var body: some View {
        ZStack(alignment: .top) {
                LinearGradient(
                    colors: [Color.indigo.opacity(0.25), Color.cyan.opacity(0.2)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 20) {
                    Text("Ventana 02")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Contenedores combinados")
                        .font(.headline)

                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.white.opacity(0.9))
                            .shadow(radius: 6)

                        VStack(spacing: 16) {
                            HStack {
                                Image(systemName: "square.grid.2x2")
                                Text("HStack dentro de ZStack")
                            }
                            .padding(.horizontal)

                            Divider()

                            VStack(alignment: .leading, spacing: 10) {
                                Text("Capa inferior (fondo)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                HStack {
                                    Capsule()
                                        .fill(Color.mint)
                                        .frame(height: 36)
                                        .overlay(Text("A").fontWeight(.bold))
                                    Capsule()
                                        .fill(Color.yellow.opacity(0.9))
                                        .frame(height: 36)
                                        .overlay(Text("B").fontWeight(.bold))
                                    Capsule()
                                        .fill(Color.pink.opacity(0.85))
                                        .frame(height: 36)
                                        .overlay(Text("C").fontWeight(.bold))
                                }
                            }
                            .padding()
                        }
                        .padding()
                    }
                    .padding(.horizontal)

                    Spacer()
                }
                .padding(.top, 24)
            }
            .navigationTitle("Ventana 02")
    }
}

#Preview {
    NavigationStack {
        Ventana02()
    }
}
