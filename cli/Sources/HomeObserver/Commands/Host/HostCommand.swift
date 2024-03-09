import Fluent
import RegexBuilder
import Vapor

struct HostCommand: AsyncCommand {

    struct Signature: CommandSignature {}

    let help = "設定されているAPIサーバーのホストを表示します。"

    func run(using context: CommandContext, signature: Signature) async throws {
        if let host = try await Host.query(on: context.application.db).first() {
            context.console.print("APIサーバーのホスト: \(host.address)")
        } else {
            context.console.print("APIサーバーのホストは設定されていません。")
        }
    }
}
