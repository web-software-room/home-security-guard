import Vapor

struct ErrorContent: Content {
    var error: Bool
    var reason: String
}
