//
//  ViewController.swift
//  lab7
//
//  Created by Tecsup on 27/04/26.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaProfesores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda")!
        cell.textLabel?.text=listaProfesores[indexPath.row].nombre
        cell.detailTextLabel?.text=listaProfesores[indexPath.row].cargo
        cell.imageView?.image = listaProfesores[indexPath.row].foto!
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // lista de Profesores
    var listaProfesores = [
        Profesor(nombre: "Aldy Montoya", cargo: "Real carry",foto:UIImage(named: "Aldy")),
        Profesor(nombre: "Fernando Mas", cargo: "Papa Commit TC",foto:UIImage(named: "+")),
        Profesor(nombre: "Leonardo Olortegui", cargo: "Artista TC",foto:UIImage(named: "Leonardo")),
        Profesor(nombre: "Alfredo Navarro", cargo: "Docente de puchos TC",foto:UIImage(named: "Alfredo")),
        Profesor(nombre: "Alexis Caihuari", cargo: "Docente de Software TC",foto:UIImage(named: "Caihuari"))
    ]
}

