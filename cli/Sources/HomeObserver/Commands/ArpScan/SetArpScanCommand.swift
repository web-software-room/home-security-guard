import Fluent
import RegexBuilder
import Vapor

struct SetArpScanCommand: AsyncCommand {

    struct Signature: CommandSignature {
        @Argument(name: "path", help: "arp-scanのpath。例: /opt/homebrew/bin/arp-scan")
        var path: String
    }

    let help = "arp-scanのPATHを設定します"

    func run(using context: CommandContext, signature: Signature) async throws {
        if let config: Configure = try await .find(.arpScanPath, on: context.application.db) {
            let old = config.value
            config.value = signature.path
            try await config.update(on: context.application.db)
            context.console.print("arp-scanのpathを\(old)から\(signature.path)に変更しました。")
        } else {
            let config = Configure(key: .arpScanPath, value: signature.path)
            try await config.create(on: context.application.db)
            context.console.print("arp-scanのpathを\(signature.path)に設定しました。")
        }
    }
}
