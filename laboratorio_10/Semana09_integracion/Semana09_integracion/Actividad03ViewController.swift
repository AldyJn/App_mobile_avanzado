//
//  Actividad03ViewController.swift
//  Actividad 03 (GLAB-S10) — SwiftUI dentro de UIKit con UIHostingController
//

import UIKit
import SwiftUI

final class Actividad03ViewController: UIViewController {
    private var hostingController: UIHostingController<MiVistaSwiftUI>?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
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
