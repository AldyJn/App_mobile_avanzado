//
//  MiViewController.swift
//  Semana09_integracion — Actividad 01 (GLAB-S10)
//

import UIKit

class MiViewController: UIViewController {
    private let tituloLabel = UILabel()
    private let mensajeLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemIndigo
        configurarInterfaz()
    }

    private func configurarInterfaz() {
        tituloLabel.text = "Actividad 01"
        tituloLabel.textColor = .white
        tituloLabel.font = .boldSystemFont(ofSize: 28)
        tituloLabel.textAlignment = .center

        mensajeLabel.text = "UIViewController de UIKit\nembebido en SwiftUI\n(MiViewControllerRepresentable)"
        mensajeLabel.textColor = .white.withAlphaComponent(0.95)
        mensajeLabel.numberOfLines = 0
        mensajeLabel.textAlignment = .center
        mensajeLabel.font = .preferredFont(forTextStyle: .title3)

        let stack = UIStackView(arrangedSubviews: [tituloLabel, mensajeLabel])
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -24)
        ])
    }
}
