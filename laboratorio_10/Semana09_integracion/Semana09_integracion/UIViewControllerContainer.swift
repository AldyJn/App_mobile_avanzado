//
//  UIViewControllerContainer.swift
//  Contenedor para que UIViewController ocupe todo el espacio en SwiftUI.
//

import SwiftUI
import UIKit

/// Envuelve un UIViewController y lo expande al tamaño que SwiftUI asigna.
struct UIViewControllerContainer: UIViewControllerRepresentable {
    let viewController: UIViewController

    func makeUIViewController(context: Context) -> ContainerViewController {
        ContainerViewController(child: viewController)
    }

    func updateUIViewController(_ container: ContainerViewController, context: Context) {
        container.updateChild(viewController)
    }
}

final class ContainerViewController: UIViewController {
    private var childController: UIViewController?

    init(child: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        embed(child)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateChild(_ child: UIViewController) {
        guard childController !== child else { return }
        childController?.willMove(toParent: nil)
        childController?.view.removeFromSuperview()
        childController?.removeFromParent()
        embed(child)
    }

    private func embed(_ child: UIViewController) {
        childController = child
        addChild(child)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(child.view)
        NSLayoutConstraint.activate([
            child.view.topAnchor.constraint(equalTo: view.topAnchor),
            child.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            child.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            child.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        child.didMove(toParent: self)
    }
}
