import Fluent
import RegexBuilder
import Vapor

struct ArpScanCommand: AsyncCommand {

    struct Signature: CommandSignature {}

    let help = "設定されているarp-scanのPATHを表示します。"

    func run(using context: CommandContext, signature: Signature) async throws {
        if let config: Configure = try await .find(.arpScanPath, on: context.application.db) {
            context.console.print("arp-scanのPATH: \(config.value)")
        } else {
            context.console.print("arp-scanのPATHは設定されていません。")
        }
    }
}
