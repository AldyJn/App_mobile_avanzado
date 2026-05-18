//
//  ViewController.swift
//  Semana10_Actividad03 — Actividad 03 (GLAB-S10)
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    private var hostingController: UIHostingController<MiVistaSwiftUI>?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Actividad 03 — UIHostingController"
        embedSwiftUIView()
    }

    private func embedSwiftUIView() {
        let hosting = UIHostingController(rootView: MiVistaSwiftUI())
        hostingController = hosting

        addChild(hosting)
        hosting.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hosting.view)

        NSLayoutConstraint.activate([
            hosting.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hosting.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hosting.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hosting.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        hosting.didMove(toParent: self)
    }
}
