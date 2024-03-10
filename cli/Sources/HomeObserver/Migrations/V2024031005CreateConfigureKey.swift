import Fluent

struct V2024031005CreateConfigureKey: AsyncMigration {
    func prepare(on database: any FluentKit.Database) async throws {
        _ = try await database.enum("configure_key")
            .case("arpScanPath")
            .case("apiServerHostAddress")
            .case("networkInterface")
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.enum("configure_key").delete()
    }
}
