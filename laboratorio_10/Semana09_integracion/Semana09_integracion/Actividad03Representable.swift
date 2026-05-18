//
//  Actividad03Representable.swift
//  Actividad 03 (GLAB-S10)
//

import SwiftUI

struct Actividad03Representable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ContainerViewController {
        ContainerViewController(child: Actividad03ViewController())
    }

    func updateUIViewController(_ uiViewController: ContainerViewController, context: Context) {}
}
