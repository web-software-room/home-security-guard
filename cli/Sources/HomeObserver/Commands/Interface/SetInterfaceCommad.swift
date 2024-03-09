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
        if let interface = try await Interface.query(on: context.application.db).first() {
            let old = interface.name
            interface.name = signature.name
            try await interface.update(on: context.application.db)
            context.console.print("インターフェイスを\(old)から\(signature.name)に変更しました。")
        } else {
            let interface = Interface(name: signature.name)
            try await interface.create(on: context.application.db)
            context.console.print("インターフェイスを\(signature.name)に設定しました。")
        }
    }
}
