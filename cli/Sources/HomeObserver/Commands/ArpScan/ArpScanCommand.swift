import Fluent
import RegexBuilder
import Vapor

struct ArpScanCommand: AsyncCommand {

    struct Signature: CommandSignature {}

    let help = "設定されているarp-scanのPATHを表示します。"

    func run(using context: CommandContext, signature: Signature) async throws {
        if let arpScan = try await ArpScan.query(on: context.application.db).first() {
            context.console.print("arp-scanのPATH: \(arpScan.path)")
        } else {
            context.console.print("arp-scanのPATHは設定されていません。")
        }
    }
}
