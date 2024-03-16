import Fluent
import RegexBuilder
import Vapor

struct InterfaceCommand: AsyncCommand {

    struct Signature: CommandSignature {}

    let help = "設定されているインターフェイスを表示します。"

    func run(using context: CommandContext, signature: Signature) async throws {
        if let config: Configure = try await .find(key: .networkInterface, on: context.application.db) {
            context.console.print("インターフェイス: \(config.value)")
        } else {
            context.console.print("インターフェイスは設定されていません。")
        }
    }
}
