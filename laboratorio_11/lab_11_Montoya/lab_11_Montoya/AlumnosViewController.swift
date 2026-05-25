//
//  AlumnosViewController.swift
//  lab_11_Montoya
//

import UIKit
import CoreData

class AlumnosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CoreDataContextProviding {

    @IBOutlet weak var tablaAlumnos: UITableView!

    var alumnos = [Alumno]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tablaAlumnos.dataSource = self
        tablaAlumnos.delegate = self
        navigationItem.prompt = "CRUD: + crear · Editar borrar · deslizar Eliminar"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(alternarEdicion))
        cargarAlumnos()
    }

    @objc private func alternarEdicion() {
        tablaAlumnos.setEditing(!tablaAlumnos.isEditing, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cargarAlumnos()
        tablaAlumnos.reloadData()
    }

    func cargarAlumnos() {
        let request: NSFetchRequest<Alumno> = Alumno.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "apellido", ascending: true)]
        do {
            alumnos = try conexion().fetch(request)
        } catch {
            print("Error al cargar alumnos")
        }
    }

    @IBAction func agregarAlumno(_ sender: UIBarButtonItem) {
        mostrarFormularioAlumno(titulo: "Nuevo Alumno", alumno: nil)
    }

    private func mostrarFormularioAlumno(titulo: String, alumno: Alumno?) {
        let alert = UIAlertController(title: titulo, message: nil, preferredStyle: .alert)
        alert.addTextField { $0.placeholder = "Apellido"; $0.text = alumno?.apellido }
        alert.addTextField { $0.placeholder = "Nombre"; $0.text = alumno?.nombre }
        alert.addTextField {
            $0.placeholder = "DNI"
            $0.text = alumno?.dni
            $0.keyboardType = .numberPad
        }

        alert.addAction(UIAlertAction(title: "Guardar", style: .default) { _ in
            guard let apellido = alert.textFields?[0].text, !apellido.isEmpty,
                  let nombre = alert.textFields?[1].text, !nombre.isEmpty,
                  let dni = alert.textFields?[2].text, !dni.isEmpty else { return }

            if let alumno {
                alumno.apellido = apellido
                alumno.nombre = nombre
                alumno.dni = dni
            } else {
                let nuevo = NSEntityDescription.insertNewObject(forEntityName: "Alumno", into: self.conexion()) as! Alumno
                nuevo.idAlumno = UUID()
                nuevo.apellido = apellido
                nuevo.nombre = nombre
                nuevo.dni = dni
            }
            self.guardarContexto()
            self.cargarAlumnos()
            self.tablaAlumnos.reloadData()
        })
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        present(alert, animated: true)
    }

    private func verDetalleAlumno(_ alumno: Alumno) {
        let mensaje = """
        Apellido: \(alumno.apellido ?? "")
        Nombre: \(alumno.nombre ?? "")
        DNI: \(alumno.dni ?? "")
        """
        let alert = UIAlertController(title: "Detalle del alumno", message: mensaje, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Editar", style: .default) { _ in
            self.mostrarFormularioAlumno(titulo: "Editar Alumno", alumno: alumno)
        })
        alert.addAction(UIAlertAction(title: "Eliminar", style: .destructive) { _ in
            self.eliminar(alumno)
        })
        alert.addAction(UIAlertAction(title: "Cerrar", style: .cancel))
        present(alert, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        alumnos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaAlumnos.dequeueReusableCell(withIdentifier: "CellAlumno", for: indexPath)
        let a = alumnos[indexPath.row]
        celda.textLabel?.text = "\(a.apellido ?? ""), \(a.nombre ?? "")"
        celda.detailTextLabel?.text = "DNI: \(a.dni ?? "")"
        celda.accessoryType = .disclosureIndicator
        return celda
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        verDetalleAlumno(alumnos[indexPath.row])
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            eliminarAlumno(at: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let eliminar = UIContextualAction(style: .destructive, title: "Eliminar") { _, _, completion in
            self.eliminarAlumno(at: indexPath)
            completion(true)
        }
        let editar = UIContextualAction(style: .normal, title: "Editar") { _, _, completion in
            self.mostrarFormularioAlumno(titulo: "Editar Alumno", alumno: self.alumnos[indexPath.row])
            completion(true)
        }
        editar.backgroundColor = .systemOrange
        return UISwipeActionsConfiguration(actions: [eliminar, editar])
    }

    private func eliminarAlumno(at indexPath: IndexPath) {
        conexion().delete(alumnos[indexPath.row])
        guardarContexto()
        alumnos.remove(at: indexPath.row)
        tablaAlumnos.deleteRows(at: [indexPath], with: .automatic)
    }

    private func eliminar(_ alumno: Alumno) {
        guard let index = alumnos.firstIndex(of: alumno) else { return }
        eliminarAlumno(at: IndexPath(row: index, section: 0))
    }
}
