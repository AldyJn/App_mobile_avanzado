import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Alumno.apellido) private var alumnos: [Alumno]
    @State private var alumnoSeleccionado: Alumno?
    @State private var mostrarFormulario = false

    var body: some View {
        TabView {
            NavigationSplitView {
                List(selection: $alumnoSeleccionado) {
                    ForEach(alumnos) { alumno in
                        NavigationLink(value: alumno) {
                            VStack(alignment: .leading) {
                                Text("\(alumno.apellido), \(alumno.nombre)")
                                    .font(.headline)
                                Text("DNI: \(alumno.dni)")
                                    .font(.subheadline)
                            }
                        }
                    }
                    .onDelete(perform: deleteAlumnos)
                }
                .navigationTitle("📋 Alumnos")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button {
                            mostrarFormulario = true
                        } label: {
                            Label("Nuevo Alumno", systemImage: "plus")
                        }
                    }
                }
            } detail: {
                if let alumno = alumnoSeleccionado {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("👤 Detalles del Alumno")
                            .font(.title2)
                            .bold()
                        Text("Nombre: \(alumno.nombre)")
                        Text("Apellido: \(alumno.apellido)")
                        Text("DNI: \(alumno.dni)")
                        Spacer()
                    }
                    .padding()
                } else {
                    Text("Selecciona un alumno")
                        .foregroundStyle(.secondary)
                }
            }
            .tabItem {
                Label("Alumnos", systemImage: "person.3")
            }

            ProductosView()
                .tabItem {
                    Label("Productos", systemImage: "cart")
                }
        }
        .sheet(isPresented: $mostrarFormulario) {
            NuevoAlumnoView()
        }
    }

    private func deleteAlumnos(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(alumnos[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Alumno.self, Producto.self], inMemory: true)
}
