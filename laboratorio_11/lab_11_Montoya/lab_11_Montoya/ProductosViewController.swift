//
//  ProductosViewController.swift
//  lab_11_Montoya
//

import UIKit
import CoreData

class ProductosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CoreDataContextProviding {

    @IBOutlet weak var tablaProductos: UITableView!

    var productos = [Producto]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tablaProductos.dataSource = self
        tablaProductos.delegate = self
        navigationItem.prompt = "CRUD: + crear · Editar borrar · deslizar Eliminar"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(alternarEdicion))
        cargarProductos()
    }

    @objc private func alternarEdicion() {
        tablaProductos.setEditing(!tablaProductos.isEditing, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cargarProductos()
        tablaProductos.reloadData()
    }

    func cargarProductos() {
        let request: NSFetchRequest<Producto> = Producto.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "idProducto", ascending: true)]
        do {
            productos = try conexion().fetch(request)
        } catch {
            print("Error al cargar productos")
        }
    }

    private var siguienteIdProducto: Int32 {
        (productos.map(\.idProducto).max() ?? 0) + 1
    }

    @IBAction func agregarProducto(_ sender: UIBarButtonItem) {
        mostrarFormularioProducto(titulo: "Nuevo Producto", producto: nil)
    }

    private func mostrarFormularioProducto(titulo: String, producto: Producto?) {
        let alert = UIAlertController(title: titulo, message: nil, preferredStyle: .alert)
        alert.addTextField {
            $0.placeholder = "Id Producto"
            $0.keyboardType = .numberPad
            if let producto {
                $0.text = String(producto.idProducto)
                $0.isEnabled = false
            } else {
                $0.text = String(self.siguienteIdProducto)
            }
        }
        alert.addTextField { $0.placeholder = "Nombre"; $0.text = producto?.nombre }
        alert.addTextField {
            $0.placeholder = "Precio"
            $0.keyboardType = .decimalPad
            if let producto { $0.text = String(producto.precio) }
        }
        alert.addTextField {
            $0.placeholder = "Stock"
            $0.keyboardType = .numberPad
            if let producto { $0.text = String(producto.stock) }
        }
        alert.addTextField { $0.placeholder = "Categoria"; $0.text = producto?.categoria }

        alert.addAction(UIAlertAction(title: "Guardar", style: .default) { _ in
            guard let idTexto = alert.textFields?[0].text, let id = Int32(idTexto),
                  let nombre = alert.textFields?[1].text, !nombre.isEmpty,
                  let precioTexto = alert.textFields?[2].text, let precio = Double(precioTexto),
                  let stockTexto = alert.textFields?[3].text, let stock = Int32(stockTexto),
                  let categoria = alert.textFields?[4].text, !categoria.isEmpty else { return }

            if let producto {
                producto.nombre = nombre
                producto.precio = precio
                producto.stock = stock
                producto.categoria = categoria
            } else {
                let nuevo = NSEntityDescription.insertNewObject(forEntityName: "Producto", into: self.conexion()) as! Producto
                nuevo.idProducto = id
                nuevo.nombre = nombre
                nuevo.precio = precio
                nuevo.stock = stock
                nuevo.categoria = categoria
            }
            self.guardarContexto()
            self.cargarProductos()
            self.tablaProductos.reloadData()
        })
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        present(alert, animated: true)
    }

    private func verDetalleProducto(_ producto: Producto) {
        let mensaje = """
        Id: \(producto.idProducto)
        Nombre: \(producto.nombre ?? "")
        Precio: S/ \(producto.precio)
        Stock: \(producto.stock)
        Categoría: \(producto.categoria ?? "")
        """
        let alert = UIAlertController(title: "Detalle del producto", message: mensaje, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Editar", style: .default) { _ in
            self.mostrarFormularioProducto(titulo: "Editar Producto", producto: producto)
        })
        alert.addAction(UIAlertAction(title: "Eliminar", style: .destructive) { _ in
            self.eliminar(producto)
        })
        alert.addAction(UIAlertAction(title: "Cerrar", style: .cancel))
        present(alert, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaProductos.dequeueReusableCell(withIdentifier: "CellProducto", for: indexPath)
        let p = productos[indexPath.row]
        celda.textLabel?.text = "[\(p.idProducto)] \(p.nombre ?? "")"
        celda.detailTextLabel?.text = "S/ \(p.precio) | Stock: \(p.stock) | \(p.categoria ?? "")"
        celda.accessoryType = .disclosureIndicator
        return celda
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        verDetalleProducto(productos[indexPath.row])
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            eliminarProducto(at: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let eliminar = UIContextualAction(style: .destructive, title: "Eliminar") { _, _, completion in
            self.eliminarProducto(at: indexPath)
            completion(true)
        }
        let editar = UIContextualAction(style: .normal, title: "Editar") { _, _, completion in
            self.mostrarFormularioProducto(titulo: "Editar Producto", producto: self.productos[indexPath.row])
            completion(true)
        }
        editar.backgroundColor = .systemOrange
        return UISwipeActionsConfiguration(actions: [eliminar, editar])
    }

    private func eliminarProducto(at indexPath: IndexPath) {
        conexion().delete(productos[indexPath.row])
        guardarContexto()
        productos.remove(at: indexPath.row)
        tablaProductos.deleteRows(at: [indexPath], with: .automatic)
    }

    private func eliminar(_ producto: Producto) {
        guard let index = productos.firstIndex(of: producto) else { return }
        eliminarProducto(at: IndexPath(row: index, section: 0))
    }
}
