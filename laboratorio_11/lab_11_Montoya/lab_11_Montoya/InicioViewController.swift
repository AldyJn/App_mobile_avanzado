//
//  InicioViewController.swift
//  lab_11_Montoya
//

import UIKit

class InicioViewController: UIViewController {

    @IBAction func irContactos(_ sender: UIButton) {
        performSegue(withIdentifier: "irContactos", sender: sender)
    }

    @IBAction func irAlumnos(_ sender: UIButton) {
        performSegue(withIdentifier: "irAlumnos", sender: sender)
    }

    @IBAction func irProductos(_ sender: UIButton) {
        performSegue(withIdentifier: "irProductos", sender: sender)
    }
}
