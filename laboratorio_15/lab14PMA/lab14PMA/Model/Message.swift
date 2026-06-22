import Foundation

struct Message: Identifiable {
    let id: String
    let text: String
    let email: String
    let timestamp: TimeInterval

    init?(id: String, dict: [String: Any]) {
        guard let text = dict["text"] as? String,
              let email = dict["email"] as? String else {
            return nil
        }
        self.id = id
        self.text = text
        self.email = email
        self.timestamp = dict["timestamp"] as? TimeInterval ?? 0
    }
}
