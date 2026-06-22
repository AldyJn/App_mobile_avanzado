import SwiftUI
import FirebaseAuth

struct MessagesView: View {
    @StateObject private var database = DatabaseService()
    @State private var newMessage = ""
    @State private var showingProfile = false   // Actividad 01

    private var currentEmail: String {
        Auth.auth().currentUser?.email ?? ""
    }

    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 10) {
                        ForEach(database.messages) { message in
                            messageBubble(message)
                                .id(message.id)
                        }
                    }
                    .padding()
                }
                .onChange(of: database.messages.count) {
                    if let last = database.messages.last {
                        withAnimation {
                            proxy.scrollTo(last.id, anchor: .bottom)
                        }
                    }
                }
            }

            HStack(spacing: 10) {
                TextField("Escribe un mensaje...", text: $newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Enviar") {
                    enviar()
                }
                .buttonStyle(PrimaryButtonStyle())
                .disabled(newMessage.trimmingCharacters(in: .whitespaces).isEmpty)
            }
            .padding()
        }
        .navigationTitle("Mensajes")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                // Actividad 03: ir a Consultas (Firestore Queries)
                NavigationLink(destination: QueryTestView()) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.blue)
                }

                // Actividad 01: ir al perfil del usuario
                Button("Profile") {
                    showingProfile = true
                }
            }
        }
        .sheet(isPresented: $showingProfile) {
            UserProfileView()
        }
        .onAppear {
            database.startListening()
        }
        .onDisappear {
            database.stopListening()
        }
    }

    private func messageBubble(_ message: Message) -> some View {
        let esMio = message.email == currentEmail
        return HStack {
            if esMio { Spacer() }
            VStack(alignment: .leading, spacing: 4) {
                Text(message.email)
                    .font(.caption2)
                    .foregroundColor(.secondary)
                Text(message.text)
                    .padding(10)
                    .background(esMio ? Color.blue : Color(.systemGray5))
                    .foregroundColor(esMio ? .white : .primary)
                    .cornerRadius(12)
            }
            if !esMio { Spacer() }
        }
    }

    private func enviar() {
        let texto = newMessage.trimmingCharacters(in: .whitespaces)
        guard !texto.isEmpty else { return }
        database.sendMessage(texto)
        newMessage = ""
    }
}

#Preview {
    NavigationStack {
        MessagesView()
    }
}
