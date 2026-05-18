//
//  MiViewControllerRepresentable.swift
//  Semana09_integracion — Actividad 01 (GLAB-S10)
//  Puente SwiftUI → UIKit
//

import SwiftUI

struct MiViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ContainerViewController {
        ContainerViewController(child: MiViewController())
    }

    func updateUIViewController(_ uiViewController: ContainerViewController, context: Context) {}
}
