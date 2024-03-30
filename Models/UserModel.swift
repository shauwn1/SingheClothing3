import Foundation

struct User: Codable, Identifiable {
    var id: Int
    var fullname: String
    var mobilenumber: String
    var email: String
    var password: String
}

struct LoginResponse: Decodable {
    let message: String
    let user: User
}
