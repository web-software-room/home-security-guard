import Fluent
import RegexBuilder
import Vapor

struct SetMemberCommand: AsyncCommand {

    struct Signature: CommandSignature {
        @Argument(name: "name", help: "メンバー名。例: 田中")
        var name: String

        @Argument(name: "MAC Address", help: "MACアドレス。例: 9E:3E:99:BB:C2:A0")
        var rawMacAddress: String

        var macAddress: MacAddress {
            get throws {
                try .init(rawMacAddress)
            }
        }
    }

    let help = "メンバーとそのMACアドレスを追加または更新します"

    func run(using context: CommandContext, signature: Signature) async throws {

        let member = try await Member.query(on: context.application.db)
            .filter(\.$name == signature.name)
            .first()

        if let member {
            try await updateMember(
                context: context, member: member, macAddress: signature.macAddress)
        } else {
            try await createMember(
                context: context, name: signature.name, macAddress: signature.macAddress)
        }
    }

    struct MacAddressValidationError: Error {}

    private func extractMacAddress(input: String) throws -> String {
        guard let match = try macAddressRegex.firstMatch(in: input.lowercased()) else {
            throw MacAddressValidationError()
        }
        return String(match.0)
    }

    private func updateMember(context: CommandContext, member: Member, macAddress: MacAddress)
        async throws
    {
        let oldMacAddress = member.rawMacAddress
        member.macAddress = macAddress
        try await member.update(on: context.application.db)
        context.console.print("\(member.name)のMACアドレスを\(oldMacAddress)から\(macAddress)に更新しました。")
    }

    private func createMember(context: CommandContext, name: String, macAddress: MacAddress)
        async throws
    {
        let newMember = Member(name: name, macAddress: macAddress)
        try await newMember.create(on: context.application.db)
        context.console.print("\(name)をMACアドレス\(macAddress)で追加しました。")
    }
}
