import Fluent
import RegexBuilder
import Vapor

struct RemoveMemberCommand: AsyncCommand {

    struct Signature: CommandSignature {
        @Argument(name: "name", help: "メンバー名。例: 田中")
        var name: String
    }

    let help = "指定したメンバーを削除します"

    func run(using context: CommandContext, signature: Signature) async throws {
        guard confirmInteractive(context, name: signature.name) else {
            return
        }

        guard
            let member = try await Member.query(on: context.application.db)
                .filter(\.$name == signature.name)
                .first()
        else {
            context.console.print("メンバー: \"\(signature.name)\"は見つかりませんでした。")
            return
        }

        try await member.delete(on: context.application.db)
        context.console.print("メンバー: \"\(signature.name)\"を削除しました。")
    }

    func confirmInteractive(_ context: CommandContext, name: String) -> Bool {
        let result = context.console.ask("本当に\"\(name)\"を削除してもいいですか？ (y/N):")
        return ["y", "yes"].contains(result.lowercased())
    }
}
