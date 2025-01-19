import Foundation

struct Address: Codable, Equatable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}
