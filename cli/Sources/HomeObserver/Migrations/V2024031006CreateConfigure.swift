import Fluent

struct V2024031006CreateConfigure: AsyncMigration {
    func prepare(on database: any FluentKit.Database) async throws {

        let keySchema = try await database.enum("configure_key").read()

        try await database.schema("configures")
            .id()
            .field("key", keySchema, .required)
            .field("value", .string, .required)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .unique(on: "key")
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("configures").delete()
    }
}
