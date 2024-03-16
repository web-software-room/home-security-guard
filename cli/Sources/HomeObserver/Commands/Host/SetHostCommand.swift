import Fluent
import RegexBuilder
import Vapor

struct SetHostCommand: AsyncCommand {

    struct Signature: CommandSignature {
        @Argument(name: "address", help: "ホスト名。例: home.lshared.dev")
        var address: String
    }

    let help = "APIサーバーのホストを設定します"

    func run(using context: CommandContext, signature: Signature) async throws {
        if let config: Configure = try await .find(
            key: .apiServerHostAddress, on: context.application.db)
        {
            let old = config.value
            config.value = signature.address
            try await config.update(on: context.application.db)
            context.console.print("APIサーバーのホストを\(old)から\(signature.address)に変更しました。")
        } else {
            let config = Configure(key: .apiServerHostAddress, value: signature.address)
            try await config.create(on: context.application.db)
            context.console.print("APIサーバーのホストを\(signature.address)に設定しました。")
        }
    }
}
