//
//  ViewController.swift
//  lab7_1
//
//  Created by Tecsup on 27/04/26.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // definir los arreglos que carguen los nombres e imagenes
    var personasArreglo = ["Aldy Montoya", "Fernando Mas", "Leonardo Olortegui", "Alfredo Navarro", "Alexis Caihuari"]
    var personasImagenarreglo = ["Aldy", "+", "Leonardo", "Alfredo", "Caihuari"]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personasArreglo.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "miCell") as? PersonasTableViewCell

        cell?.PersonaNombre.text = "\(personasArreglo[indexPath.row])"
        cell?.PersonaImagen.image = UIImage(named: "\(personasImagenarreglo[indexPath.row])")

        return cell ?? <#default value#>
    }
}
