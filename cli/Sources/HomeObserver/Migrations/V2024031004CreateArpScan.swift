import Fluent

struct V2024031004CreateArpScan: AsyncMigration {
    func prepare(on database: any FluentKit.Database) async throws {
        try await database.schema("arp_scans")
            .id()
            .field("path", .string, .required)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .unique(on: "path")
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("arp_scans").delete()
    }
}
