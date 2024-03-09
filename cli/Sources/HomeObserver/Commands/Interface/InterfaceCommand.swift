import Fluent
import RegexBuilder
import Vapor

struct InterfaceCommand: AsyncCommand {

    struct Signature: CommandSignature {}

    let help = "設定されているインターフェイスを表示します。"

    func run(using context: CommandContext, signature: Signature) async throws {
        if let interface = try await Interface.query(on: context.application.db).first() {
            context.console.print("インターフェイス: \(interface.name)")
        } else {
            context.console.print("インターフェイスは設定されていません。")
        }
    }
}
