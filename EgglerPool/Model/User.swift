import Foundation

struct User {
    let email: String
    let firstName: String
    let lastName: String
    var name: String { return firstName + " " + lastName }
}
