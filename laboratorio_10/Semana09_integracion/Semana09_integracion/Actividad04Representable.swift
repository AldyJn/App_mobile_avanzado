//
//  Actividad04Representable.swift
//  Actividad 04 (GLAB-S10)
//

import SwiftUI

struct Actividad04Representable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        UINavigationController(rootViewController: Actividad04MenuViewController())
    }

    func updateUIViewController(_ navigationController: UINavigationController, context: Context) {}
}
