import SwiftUI
import SwiftData
import PhotosUI
import UIKit

struct NuevoProductoView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    var productoEditar: Producto?
    var siguienteId: Int

    @State private var idProducto: String = ""
    @State private var nombre = ""
    @State private var precio = ""
    @State private var stock = ""
    @State private var categoria = ""
    @State private var imagenSeleccionada: PhotosPickerItem?
    @State private var imagenData: Data?

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Datos del Producto")) {
                    TextField("Id Producto", text: $idProducto)
                        .keyboardType(.numberPad)
                        .disabled(productoEditar != nil)
                    TextField("Nombre", text: $nombre)
                    TextField("Precio", text: $precio)
                        .keyboardType(.decimalPad)
                    TextField("Stock", text: $stock)
                        .keyboardType(.numberPad)
                    TextField("Categoría", text: $categoria)
                }

                Section(header: Text("Imagen (opcional)")) {
                    PhotosPicker(selection: $imagenSeleccionada, matching: .images) {
                        Label("Seleccionar imagen", systemImage: "photo")
                    }
                    if let imagenData, let uiImage = UIImage(data: imagenData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 120)
                    }
                }

                Button(productoEditar == nil ? "Guardar Producto" : "Actualizar Producto") {
                    guardarProducto()
                }
                .disabled(!formularioValido)
            }
            .navigationTitle(productoEditar == nil ? "Nuevo Producto" : "Editar Producto")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
            }
            .onAppear(perform: cargarDatos)
            .onChange(of: imagenSeleccionada) { _, nuevoItem in
                Task {
                    if let data = try? await nuevoItem?.loadTransferable(type: Data.self) {
                        imagenData = data
                    }
                }
            }
        }
    }

    private var formularioValido: Bool {
        !nombre.isEmpty && !precio.isEmpty && !stock.isEmpty && !categoria.isEmpty &&
        (productoEditar != nil || !idProducto.isEmpty)
    }

    private func cargarDatos() {
        if let producto = productoEditar {
            idProducto = String(producto.idProducto)
            nombre = producto.nombre
            precio = String(producto.precio)
            stock = String(producto.stock)
            categoria = producto.categoria
            imagenData = producto.imagenData
        } else {
            idProducto = String(siguienteId)
        }
    }

    private func guardarProducto() {
        guard let id = Int(idProducto),
              let precioValor = Double(precio),
              let stockValor = Int(stock) else { return }

        if let producto = productoEditar {
            producto.nombre = nombre
            producto.precio = precioValor
            producto.stock = stockValor
            producto.categoria = categoria
            producto.imagenData = imagenData
        } else {
            let nuevo = Producto(
                idProducto: id,
                nombre: nombre,
                precio: precioValor,
                stock: stockValor,
                categoria: categoria,
                imagenData: imagenData
            )
            modelContext.insert(nuevo)
        }

        do {
            try modelContext.save()
        } catch {
            print("Error al guardar producto: \(error)")
        }
        dismiss()
    }
}
