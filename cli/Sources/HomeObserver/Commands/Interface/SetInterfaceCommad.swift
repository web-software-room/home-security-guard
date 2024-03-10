import Fluent
import RegexBuilder
import Vapor

struct SetInterfaceCommand: AsyncCommand {

    struct Signature: CommandSignature {
        @Argument(name: "name", help: "インターフェイス名。例: en0")
        var name: String
    }

    let help = "インターフェイスを設定します"

    func run(using context: CommandContext, signature: Signature) async throws {
        if let config: Configure = try await .find(.networkInterface, on: context.application.db) {
            let old = config.value
            config.value = signature.name
            try await config.update(on: context.application.db)
            context.console.print("インターフェイスを\(old)から\(signature.name)に変更しました。")
        } else {
            let config = Configure(key: .networkInterface, value: signature.name)
            try await config.create(on: context.application.db)
            context.console.print("インターフェイスを\(signature.name)に設定しました。")
        }
    }
}
