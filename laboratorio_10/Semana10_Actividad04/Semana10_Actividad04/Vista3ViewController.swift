//
//  Vista3ViewController.swift
//  Semana10_Actividad04 — Actividad 04 (GLAB-S10)
//

import UIKit

final class Vista3ViewController: UIViewController {
    private let montoField = UITextField()
    private let tasaField = UITextField()
    private let plazoField = UITextField()
    private let resultadoLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple.withAlphaComponent(0.15)
        title = "Vista 3 — Préstamo"
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
        titulo.text = "Simulador de préstamo (Perú)"
        titulo.font = .preferredFont(forTextStyle: .title2)
        titulo.textAlignment = .center
        titulo.numberOfLines = 0

        configurarCampo(montoField, placeholder: "Monto del préstamo (S/)")
        configurarCampo(tasaField, placeholder: "TEA anual (%)")
        configurarCampo(plazoField, placeholder: "Plazo (meses)")

        let calcularButton = UIButton(type: .system)
        calcularButton.setTitle("Simular préstamo", for: .normal)
        calcularButton.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        calcularButton.addTarget(self, action: #selector(simularPrestamo), for: .touchUpInside)

        resultadoLabel.text = "Cuota mensual: —"
        resultadoLabel.font = .preferredFont(forTextStyle: .body)
        resultadoLabel.textAlignment = .center
        resultadoLabel.numberOfLines = 0

        let stack = UIStackView(arrangedSubviews: [
            titulo, montoField, tasaField, plazoField, calcularButton, resultadoLabel
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

    @objc private func simularPrestamo() {
        guard let monto = Double(montoField.text ?? ""),
              let tasa = Double(tasaField.text ?? ""),
              let plazo = Int(plazoField.text ?? ""),
              monto > 0, tasa >= 0, plazo > 0 else {
            resultadoLabel.text = "Ingrese datos válidos"
            return
        }

        let n = Double(plazo)
        let i = tasa / 12.0 / 100.0

        let cuota: Double
        if i == 0 {
            cuota = monto / n
        } else {
            let factor = pow(1 + i, n)
            cuota = monto * (i * factor) / (factor - 1)
        }

        let montoTotal = cuota * n
        let interesTotal = montoTotal - monto

        resultadoLabel.text = """
        Cuota mensual: S/ \(String(format: "%.2f", cuota))
        Monto total a pagar: S/ \(String(format: "%.2f", montoTotal))
        Interés total: S/ \(String(format: "%.2f", interesTotal))
        """
    }
}
