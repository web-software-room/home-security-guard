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
        if let host = try await Host.query(on: context.application.db).first() {
            let old = host.address
            host.address = signature.address
            try await host.update(on: context.application.db)
            context.console.print("APIサーバーのホストを\(old)から\(signature.address)に変更しました。")
        } else {
            let host = Host(address: signature.address)
            try await host.create(on: context.application.db)
            context.console.print("APIサーバーのホストを\(signature.address)に設定しました。")
        }
    }
}
