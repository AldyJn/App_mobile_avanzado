import SwiftUI
import FirebaseAuth
import FirebaseCore

struct AuthView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isSignedIn = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var authStateListener: AuthStateDidChangeListenerHandle?

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Lab 14: Firebase")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 50)

                Spacer()

                if isSignedIn {
                    VStack(spacing: 20) {
                        Text("Welcome!")
                            .font(.title)
                            .foregroundColor(.green)

                        Text(Auth.auth().currentUser?.email ?? "You are signed in")
                            .font(.body)
                            .foregroundColor(.secondary)

                        NavigationLink("Ir a Mensajes") {
                            MessagesView()
                        }
                        .buttonStyle(PrimaryButtonStyle())

                        Button("Sign Out") {
                            signOut()
                        }
                        .buttonStyle(SignOutButtonStyle())
                    }
                } else {
                    VStack(spacing: 15) {
                        TextField("Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)

                        SecureField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        HStack(spacing: 20) {
                            Button("Sign In") {
                                signIn()
                            }
                            .buttonStyle(PrimaryButtonStyle())

                            Button("Sign Up") {
                                signUp()
                            }
                            .buttonStyle(SecondaryButtonStyle())
                        }
                    }
                    .padding(.horizontal, 30)
                }

                Spacer()
            }
            .navigationBarHidden(true)
        }
        .alert("Message", isPresented: $showAlert) {
            Button("OK") { }
        } message: {
            Text(alertMessage)
        }
        .onAppear {
            checkAuthState()
        }
        .onChange(of: isSignedIn) {
            if !isSignedIn {
                email = ""
                password = ""
            }
        }
    }

    private func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                showMessage(error.localizedDescription)
            } else {
                showMessage("Inicio de sesión correcto")
            }
        }
    }

    private func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if let error = error {
                showMessage(error.localizedDescription)
            } else {
                showMessage("Usuario registrado correctamente")
            }
        }
    }

    private func signOut() {
        do {
            try Auth.auth().signOut()
            showMessage("Sesión cerrada")
        } catch {
            showMessage(error.localizedDescription)
        }
    }

    private func checkAuthState() {
        authStateListener = Auth.auth().addStateDidChangeListener { _, user in
            isSignedIn = (user != nil)
        }
    }

    private func showMessage(_ message: String) {
        alertMessage = message
        showAlert = true
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.blue)
            .padding()
            .background(Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.blue, lineWidth: 2)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct SignOutButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .background(Color.red)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

#Preview {
    AuthView()
}
