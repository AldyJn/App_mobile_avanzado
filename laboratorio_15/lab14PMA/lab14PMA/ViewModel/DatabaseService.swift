import Foundation
import Combine
import FirebaseDatabase
import FirebaseAuth

class DatabaseService: ObservableObject {
    @Published var messages: [Message] = []
    
    private let profileService = UserProfileService()

    private let ref = Database.database(url: "https://lab14pma-default-rtdb.firebaseio.com").reference().child("messages")
    private var handle: DatabaseHandle?

    func startListening() {
        handle = ref.queryOrdered(byChild: "timestamp")
            .observe(.value) { [weak self] snapshot in
                var nuevos: [Message] = []
                for case let child as DataSnapshot in snapshot.children {
                    if let dict = child.value as? [String: Any],
                       let message = Message(id: child.key, dict: dict) {
                        nuevos.append(message)
                    }
                }
                self?.messages = nuevos
            }
    }

    func stopListening() {
        if let handle = handle {
            ref.removeObserver(withHandle: handle)
        }
    }

    func sendMessage(_ text: String) {
        let email = Auth.auth().currentUser?.email ?? "anónimo"
        let data: [String: Any] = [
            "text": text,
            "email": email,
            "timestamp": Date().timeIntervalSince1970
        ]
        ref.childByAutoId().setValue(data)

        // Activity 01: increment the user's message counter in Firestore.
        profileService.addMessage()
    }
}
