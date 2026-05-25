import SwiftUI
import SwiftData

struct ProductosView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Producto.idProducto) private var productos: [Producto]
    @State private var productoSeleccionado: Producto?
    @State private var mostrarFormulario = false
    @State private var productoAEditar: Producto?

    private var siguienteId: Int {
        (productos.map(\.idProducto).max() ?? 0) + 1
    }

    var body: some View {
        NavigationSplitView {
            List(selection: $productoSeleccionado) {
                ForEach(productos) { producto in
                    NavigationLink(value: producto) {
                        HStack(spacing: 12) {
                            if let data = producto.imagenData, let uiImage = UIImage(data: data) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 44, height: 44)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            } else {
                                Image(systemName: "shippingbox")
                                    .frame(width: 44, height: 44)
                                    .foregroundStyle(.secondary)
                            }
                            VStack(alignment: .leading) {
                                Text(producto.nombre)
                                    .font(.headline)
                                Text("ID: \(producto.idProducto) · \(producto.categoria)")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                Text("S/ \(producto.precio, specifier: "%.2f") · Stock: \(producto.stock)")
                                    .font(.caption)
                            }
                        }
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            eliminar(producto)
                        } label: {
                            Label("Eliminar", systemImage: "trash")
                        }
                        Button {
                            productoAEditar = producto
                            mostrarFormulario = true
                        } label: {
                            Label("Editar", systemImage: "pencil")
                        }
                        .tint(.orange)
                    }
                }
                .onDelete(perform: deleteProductos)
            }
            .navigationTitle("📦 Productos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button {
                        productoAEditar = nil
                        mostrarFormulario = true
                    } label: {
                        Label("Nuevo Producto", systemImage: "plus")
                    }
                }
            }
        } detail: {
            if let producto = productoSeleccionado {
                DetalleProductoView(producto: producto)
            } else {
                Text("Selecciona un producto")
                    .foregroundStyle(.secondary)
            }
        }
        .sheet(isPresented: $mostrarFormulario) {
            NuevoProductoView(productoEditar: productoAEditar, siguienteId: siguienteId)
        }
    }

    private func eliminar(_ producto: Producto) {
        modelContext.delete(producto)
        if productoSeleccionado?.idProducto == producto.idProducto {
            productoSeleccionado = nil
        }
    }

    private func deleteProductos(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(productos[index])
            }
        }
    }
}

struct DetalleProductoView: View {
    let producto: Producto

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Detalle del Producto")
                .font(.title2)
                .bold()

            if let data = producto.imagenData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }

            Group {
                Text("Id Producto: \(producto.idProducto)")
                Text("Nombre: \(producto.nombre)")
                Text("Precio: S/ \(producto.precio, specifier: "%.2f")")
                Text("Stock: \(producto.stock)")
                Text("Categoría: \(producto.categoria)")
            }
            .font(.body)

            Spacer()
        }
        .padding()
    }
}
