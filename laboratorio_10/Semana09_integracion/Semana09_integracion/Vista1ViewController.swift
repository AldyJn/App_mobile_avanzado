//
//  Vista1ViewController.swift
//  Semana10_Actividad04 — Actividad 04 (GLAB-S10)
//

import UIKit

final class Vista1ViewController: UIViewController {
    private let numeroAField = UITextField()
    private let numeroBField = UITextField()
    private let resultadoLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal.withAlphaComponent(0.15)
        title = "Vista 1 — Suma"
        configurarMenuRetroceso()
        configurarInterfaz()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func configurarMenuRetroceso() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Menú",
            style: .plain,
            target: self,
            action: #selector(volverAlMenu)
        )
    }

    @objc private func volverAlMenu() {
        navigationController?.popToRootViewController(animated: true)
    }

    private func configurarInterfaz() {
        let titulo = UILabel()
        titulo.text = "Operación sencilla: suma"
        titulo.font = .preferredFont(forTextStyle: .title2)
        titulo.textAlignment = .center

        configurarCampo(numeroAField, placeholder: "Número A")
        configurarCampo(numeroBField, placeholder: "Número B")

        let calcularButton = UIButton(type: .system)
        calcularButton.setTitle("Calcular suma", for: .normal)
        calcularButton.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        calcularButton.addTarget(self, action: #selector(calcularSuma), for: .touchUpInside)

        resultadoLabel.text = "Resultado: —"
        resultadoLabel.font = .preferredFont(forTextStyle: .title3)
        resultadoLabel.textAlignment = .center
        resultadoLabel.numberOfLines = 0

        let stack = UIStackView(arrangedSubviews: [
            titulo, numeroAField, numeroBField, calcularButton, resultadoLabel
        ])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }

    private func configurarCampo(_ field: UITextField, placeholder: String) {
        field.placeholder = placeholder
        field.borderStyle = .roundedRect
        field.keyboardType = .decimalPad
    }

    @objc private func calcularSuma() {
        guard let a = Double(numeroAField.text ?? ""),
              let b = Double(numeroBField.text ?? "") else {
            resultadoLabel.text = "Ingrese números válidos"
            return
        }
        resultadoLabel.text = String(format: "Resultado: %.2f", a + b)
    }
}
