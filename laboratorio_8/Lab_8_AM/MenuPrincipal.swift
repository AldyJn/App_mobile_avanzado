//
//  MenuPrincipal.swift
//  Lab_8_AM
//
//  Menú principal con navegación (NavigationLink) a las actividades del laboratorio.
//

import SwiftUI

struct MenuPrincipal: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Laboratorio 8 — SwiftUI") {
                    NavigationLink("Actividad 01 — Stacks (ContentView)") {
                        ContentView()
                    }
                    NavigationLink("Ventana 02 — Contenedores combinados") {
                        Ventana02()
                    }
                    NavigationLink("Ventana 03 — Peso ideal") {
                        Ventana03()
                    }
                }

                Section("TECSUP / aplicaciones") {
                    NavigationLink("Notas de teoría (4 notas + laboratorio)") {
                        NotasTeoriaView()
                    }
                    NavigationLink("Cálculo CTS") {
                        CalculoCTSView()
                    }
                    NavigationLink("Pago de instructores") {
                        PagoInstructorView()
                    }
                    NavigationLink("Trabajo grupal — CxC y CxP") {
                        ContabilidadTrabajoGrupalView()
                    }
                }
            }
            .navigationTitle("Menú principal")
        }
    }
}

#Preview {
    MenuPrincipal()
}
