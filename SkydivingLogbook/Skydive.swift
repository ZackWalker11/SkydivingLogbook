import Foundation

// Structure for Skydive Data
struct Skydive: Identifiable, Codable {
    var id = UUID()
    var jumpNumber: Int
    var jumpElevation: Int
    var jumpPartners: String
    var location: String
    var details: String
}
