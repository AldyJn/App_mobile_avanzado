//
//  ViewController.swift
//  lab_11_Montoya
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CoreDataContextProviding {

    @IBOutlet weak var TablaContacto: UITableView!

    var contactos = [Contacto]()

    override func viewDidLoad() {
        super.viewDidLoad()
        TablaContacto.dataSource = self
        TablaContacto.delegate = self
        navigationItem.prompt = "CRUD: + crear · Editar borrar · deslizar Eliminar"
        let btnEditar = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(alternarEdicion))
        navigationItem.leftBarButtonItem = btnEditar
        cargarInfoCoreData()
    }

    @objc private func alternarEdicion() {
        TablaContacto.setEditing(!TablaContacto.isEditing, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cargarInfoCoreData()
        TablaContacto.reloadData()
    }

    func cargarInfoCoreData() {
        let fetchRequest: NSFetchRequest<Contacto> = Contacto.fetchRequest()
        do {
            contactos = try conexion().fetch(fetchRequest)
        } catch {
            print("Error al cargar la BD")
        }
    }

    @IBAction func agregarContacto(_ sender: UIBarButtonItem) {
        mostrarFormularioContacto(titulo: "Agregar Contacto", contacto: nil)
    }

    private func mostrarFormularioContacto(titulo: String, contacto: Contacto?) {
        let alert = UIAlertController(title: titulo, message: "Nuevo Contacto", preferredStyle: .alert)
        alert.addTextField { $0.placeholder = "Nombre"; $0.text = contacto?.nombre }
        alert.addTextField { $0.placeholder = "Telefono"; $0.text = contacto?.telefono }
        alert.addTextField { $0.placeholder = "Direccion"; $0.text = contacto?.direccion }

        alert.addAction(UIAlertAction(title: "Guardar", style: .default) { _ in
            guard let nombre = alert.textFields?[0].text, !nombre.isEmpty,
                  let telefono = alert.textFields?[1].text,
                  let direccion = alert.textFields?[2].text else { return }

            if let contacto {
                contacto.nombre = nombre
                contacto.telefono = telefono
                contacto.direccion = direccion
            } else {
                let nuevo = NSEntityDescription.insertNewObject(forEntityName: "Contacto", into: self.conexion()) as! Contacto
                nuevo.nombre = nombre
                nuevo.telefono = telefono
                nuevo.direccion = direccion
            }
            self.guardarContexto()
            self.cargarInfoCoreData()
            self.TablaContacto.reloadData()
        })
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        present(alert, animated: true)
    }

    private func verDetalleContacto(_ contacto: Contacto) {
        let mensaje = """
        Nombre: \(contacto.nombre ?? "")
        Teléfono: \(contacto.telefono ?? "")
        Dirección: \(contacto.direccion ?? "")
        """
        let alert = UIAlertController(title: "Detalle del contacto", message: mensaje, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Editar", style: .default) { _ in
            self.mostrarFormularioContacto(titulo: "Editar Contacto", contacto: contacto)
        })
        alert.addAction(UIAlertAction(title: "Eliminar", style: .destructive) { _ in
            self.eliminar(contacto)
        })
        alert.addAction(UIAlertAction(title: "Cerrar", style: .cancel))
        present(alert, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contactos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = TablaContacto.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let c = contactos[indexPath.row]
        celda.textLabel?.text = c.nombre
        celda.detailTextLabel?.text = "\(c.telefono ?? "") | \(c.direccion ?? "")"
        celda.accessoryType = .disclosureIndicator
        return celda
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        verDetalleContacto(contactos[indexPath.row])
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            eliminarContacto(at: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let eliminar = UIContextualAction(style: .destructive, title: "Eliminar") { _, _, completion in
            self.eliminarContacto(at: indexPath)
            completion(true)
        }
        let editar = UIContextualAction(style: .normal, title: "Editar") { _, _, completion in
            self.mostrarFormularioContacto(titulo: "Editar Contacto", contacto: self.contactos[indexPath.row])
            completion(true)
        }
        editar.backgroundColor = .systemOrange
        return UISwipeActionsConfiguration(actions: [eliminar, editar])
    }

    func eliminarContacto(at indexPath: IndexPath) {
        conexion().delete(contactos[indexPath.row])
        guardarContexto()
        contactos.remove(at: indexPath.row)
        TablaContacto.deleteRows(at: [indexPath], with: .automatic)
    }

    private func eliminar(_ contacto: Contacto) {
        guard let index = contactos.firstIndex(of: contacto) else { return }
        eliminarContacto(at: IndexPath(row: index, section: 0))
    }
}
