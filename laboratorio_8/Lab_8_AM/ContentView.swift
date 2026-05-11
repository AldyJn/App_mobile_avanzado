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

                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))

                    HStack(spacing: 12) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.red.opacity(0.7))
                            .frame(width: 50, height: 50)
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
