import Fluent

struct V2024031003CreateHost: AsyncMigration {
    func prepare(on database: any FluentKit.Database) async throws {
        try await database.schema("hosts")
            .id()
            .field("address", .string, .required)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .unique(on: "address")
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("hosts").delete()
    }
}
