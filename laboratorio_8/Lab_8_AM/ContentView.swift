//
//  ContentView.swift
//  Lab_8_AM
//
//  Actividad 01 — Contenedores HStack, VStack, ZStack
//  Created by Juan Leon on 15/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 24) {
                    Text("Actividad 01")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Stacks en SwiftUI")
                        .font(.title2)

                    VStack(alignment: .leading, spacing: 8) {
                        Label("VStack: elementos en vertical", systemImage: "arrow.down")
                        Label("HStack: elementos en horizontal", systemImage: "arrow.left.arrow.right")
                        Label("ZStack: capas superpuestas", systemImage: "square.2.layers.3d")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))

                    HStack(spacing: 12) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.red.opacity(0.7))
                            .frame(width: 50, height: 50)
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.green.opacity(0.7))
                            .frame(width: 50, height: 50)
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.blue.opacity(0.7))
                            .frame(width: 50, height: 50)
                    }

                    ZStack {
                        Circle()
                            .fill(Color.orange.opacity(0.35))
                            .frame(width: 120, height: 120)
                        Circle()
                            .fill(Color.purple.opacity(0.45))
                            .frame(width: 80, height: 80)
                        Text("ZStack")
                            .font(.caption)
                            .fontWeight(.semibold)
                    }

                    Spacer(minLength: 0)
            }
            .padding()
        }
        .navigationTitle("Lab 8 — Inicio")
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
