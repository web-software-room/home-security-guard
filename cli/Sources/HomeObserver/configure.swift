import CLIKit
import Fluent
import FluentSQLiteDriver
import NIOSSL
import Vapor

func configure(_ app: Application) async throws {
    app.asyncCommands.use(PushCommand(), as: "push", isDefault: true)
    app.asyncCommands.use(SetMemberCommand(), as: "set-member")
    app.asyncCommands.use(RemoveMemberCommand(), as: "remove-member")
    app.asyncCommands.use(MemberCommand(), as: "member")
    app.asyncCommands.use(InterfaceCommand(), as: "interface")
    app.asyncCommands.use(SetInterfaceCommand(), as: "set-interface")
    app.asyncCommands.use(HostCommand(), as: "host")
    app.asyncCommands.use(SetHostCommand(), as: "set-host")
    app.asyncCommands.use(ArpScanCommand(), as: "arp-scan")
    app.asyncCommands.use(SetArpScanCommand(), as: "set-arp-scan")

    let homeDirectoryPath = NSHomeDirectory()
    let directoryPath = "\(homeDirectoryPath)/.homep-observer"
    let fileManager = FileManager()
    if !fileManager.fileExists(atPath: directoryPath) {
        try fileManager.createDirectory(
            atPath: directoryPath, withIntermediateDirectories: false, attributes: nil)
    }

    app.databases.use(
        DatabaseConfigurationFactory.sqlite(
            .file("\(homeDirectoryPath)/.homep-observer/db.sqlite")), as: .sqlite)
    app.migrations.add(V2024031001CreateMember())
    app.migrations.add(V2024031002CreateInterface())
    app.migrations.add(V2024031003CreateHost())
    app.migrations.add(V2024031004CreateArpScan())
    app.migrations.add(V2024031005CreateConfigureKey())
    app.migrations.add(V2024031006CreateConfigure())
    app.migrations.add(V2024031007DeleteInterfaceHostArpScan())

    try await app.autoMigrate()
}
