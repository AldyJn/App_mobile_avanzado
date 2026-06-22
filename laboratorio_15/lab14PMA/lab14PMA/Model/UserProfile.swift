import Foundation

nonisolated struct UserProfile: Codable {

    let email: String
    var displayName: String
    var lastName: String          // TAREA Actividad 01: apellido
    var messageCount: Int

    init(email: String, displayName: String, lastName: String = "") {
        self.email = email
        self.displayName = displayName
        self.lastName = lastName
        self.messageCount = 0
    }
}
