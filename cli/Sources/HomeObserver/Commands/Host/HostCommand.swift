import Fluent
import RegexBuilder
import Vapor

struct HostCommand: AsyncCommand {

    struct Signature: CommandSignature {}

    let help = "設定されているAPIサーバーのホストを表示します。"

    func run(using context: CommandContext, signature: Signature) async throws {
        if let config: Configure = try await .find(
            key: .apiServerHostAddress, on: context.application.db)
        {
            context.console.print("APIサーバーのホスト: \(config.value)")
        } else {
            context.console.print("APIサーバーのホストは設定されていません。")
        }
    }
}
