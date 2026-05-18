//
//  Actividad04MenuViewController.swift
//  Actividad 04 (GLAB-S10) — Menu SwiftUI en UIKit
//

import UIKit
import SwiftUI

final class Actividad04MenuViewController: UIViewController {
    private var hostingController: UIHostingController<MenuNavigationView>?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        mostrarMenu()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    private func mostrarMenu() {
        removerHosting()

        let menuView = MenuNavigationView(
            onVista1: { [weak self] in self?.navegarA(Vista1ViewController()) },
            onVista2: { [weak self] in self?.navegarA(Vista2ViewController()) },
            onVista3: { [weak self] in self?.navegarA(Vista3ViewController()) }
        )

        let hosting = UIHostingController(rootView: menuView)
        hostingController = hosting
        embed(hosting)
    }

    private func navegarA(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func embed(_ hosting: UIHostingController<some View>) {
        addChild(hosting)
        hosting.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hosting.view)

        NSLayoutConstraint.activate([
            hosting.view.topAnchor.constraint(equalTo: view.topAnchor),
            hosting.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hosting.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hosting.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        hosting.didMove(toParent: self)
    }

    private func removerHosting() {
        hostingController?.willMove(toParent: nil)
        hostingController?.view.removeFromSuperview()
        hostingController?.removeFromParent()
        hostingController = nil
    }
}
