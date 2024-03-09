import Fluent

struct V2024031001CreateMember: AsyncMigration {
    func prepare(on database: any FluentKit.Database) async throws {
        try await database.schema("members")
            .id()
            .field("name", .string, .required)
            .field("mac_address", .string, .required)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .unique(on: "name")
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("members").delete()
    }
}
