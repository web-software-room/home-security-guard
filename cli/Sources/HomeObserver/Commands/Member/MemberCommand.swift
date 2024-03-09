import Fluent
import RegexBuilder
import Vapor

struct MemberCommand: AsyncCommand {

    struct Signature: CommandSignature {}

    let help = "設定されているメンバーの一覧を取得します"

    func run(using context: CommandContext, signature: Signature) async throws {

        let members = try await Member.query(on: context.application.db).all()

        if members.isEmpty {
            context.console.print("メンバーは登録されていません。")
            return
        }

        for member in members {
            context.console.print("\(member.name)\n\t\(member.macAddress)")
        }
    }
}
