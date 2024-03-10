import Fluent

struct V2024031007DeleteInterfaceHostArpScan: AsyncMigration {
    func prepare(on database: any FluentKit.Database) async throws {
        try await V2024031003CreateHost().revert(on: database)
        try await V2024031004CreateArpScan().revert(on: database)
        try await V2024031002CreateInterface().revert(on: database)
    }

    func revert(on database: any Database) async throws {
        try await V2024031002CreateInterface().prepare(on: database)
        try await V2024031004CreateArpScan().prepare(on: database)
        try await V2024031003CreateHost().prepare(on: database)
    }
}
