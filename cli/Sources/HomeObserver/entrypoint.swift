import CLIKit
import Vapor

@main
enum Entrypoint {
    static func main() async throws {
        let app = Vapor.Application()
        defer { app.shutdown() }
        try await app.cliKit(configure: configure)
    }
}
