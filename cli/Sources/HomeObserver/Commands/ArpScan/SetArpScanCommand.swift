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
        if let arpScan = try await ArpScan.query(on: context.application.db).first() {
            let old = arpScan.path
            arpScan.path = signature.path
            try await arpScan.update(on: context.application.db)
            context.console.print("arp-scanのpathを\(old)から\(signature.path)に変更しました。")
        } else {
            let arpScan = ArpScan(path: signature.path)
            try await arpScan.create(on: context.application.db)
            context.console.print("arp-scanのpathを\(signature.path)に設定しました。")
        }
    }
}
