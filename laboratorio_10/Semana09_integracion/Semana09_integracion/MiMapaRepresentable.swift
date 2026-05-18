//
//  MiMapaRepresentable.swift
//  Semana09_integracion — Actividad 02 (GLAB-S10)
//  Puente SwiftUI → UIKit (MapKit)
//

import SwiftUI

struct MiMapaRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ContainerViewController {
        ContainerViewController(child: MiMapaViewController())
    }

    func updateUIViewController(_ uiViewController: ContainerViewController, context: Context) {}
}
