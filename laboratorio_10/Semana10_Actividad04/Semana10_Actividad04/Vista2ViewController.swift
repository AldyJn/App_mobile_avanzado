//
//  Vista2ViewController.swift
//  Semana10_Actividad04 — Actividad 04 (GLAB-S10)
//

import UIKit

final class Vista2ViewController: UIViewController {
    private let capitalField = UITextField()
    private let tasaField = UITextField()
    private let aniosField = UITextField()
    private let resultadoLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemOrange.withAlphaComponent(0.15)
        title = "Vista 2 — Interés compuesto"
        configurarMenuRetroceso()
        configurarInterfaz()
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
        titulo.text = "Cálculo de interés compuesto"
        titulo.font = .preferredFont(forTextStyle: .title2)
        titulo.textAlignment = .center
        titulo.numberOfLines = 0

        configurarCampo(capitalField, placeholder: "Monto inicial (capital)")
        configurarCampo(tasaField, placeholder: "Tasa anual (%)")
        configurarCampo(aniosField, placeholder: "Número de años")

        let calcularButton = UIButton(type: .system)
        calcularButton.setTitle("Calcular monto final", for: .normal)
        calcularButton.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        calcularButton.addTarget(self, action: #selector(calcularInteres), for: .touchUpInside)

        resultadoLabel.text = "Monto final: —"
        resultadoLabel.font = .preferredFont(forTextStyle: .title3)
        resultadoLabel.textAlignment = .center
        resultadoLabel.numberOfLines = 0

        let stack = UIStackView(arrangedSubviews: [
            titulo, capitalField, tasaField, aniosField, calcularButton, resultadoLabel
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

    @objc private func calcularInteres() {
        guard let capital = Double(capitalField.text ?? ""),
              let tasa = Double(tasaField.text ?? ""),
              let anios = Double(aniosField.text ?? ""),
              capital > 0, tasa >= 0, anios > 0 else {
            resultadoLabel.text = "Ingrese datos válidos"
            return
        }

        let montoFinal = capital * pow(1 + tasa / 100, anios)
        resultadoLabel.text = String(format: "Monto final: S/ %.2f", montoFinal)
    }
}
