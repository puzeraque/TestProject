import Foundation

struct ProfileModel: Codable {
    let firstName: String
    let secondName: String
    let email: String
}

extension ProfileModel {
    var fullName: String {
        return "\(firstName) \(secondName)"
    }
}

enum ProfileStorage {
    enum Keys {
        static let profileKey = "profileKey"
    }

    static var profileInfo: ProfileModel? {
        set(newValue) {
            if let encoded = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: Keys.profileKey)
            }
        }
        get {
            // Retrieve from UserDefaults
            if let data = UserDefaults.standard.value(forKey: Keys.profileKey) as? Data,
               let profile = try? JSONDecoder().decode(ProfileModel.self, from: data) {
                    return profile
            } else { return nil }

        }
    }
}
