import SwiftCommand
import Vapor

struct PushCommand: AsyncCommand {

    struct Signature: CommandSignature {}

    let help = "サーバーに状態を送信します。"

    func run(using context: ConsoleKitCommands.CommandContext, signature: Signature) async throws {
        let configures: [ConfigureKey: Configure] = Dictionary(
            grouping: try await Configure.query(on: context.application.db).all(),
            by: \.key
        ).compactMapValues(\.first)

        guard let host = configures[.apiServerHostAddress] else {
            context.console.print("APIサーバーのホストが設定されていません。")
            return
        }
        guard let arpScan = configures[.arpScanPath] else {
            context.console.print("arp-scanが設定されていません。")
            return
        }
        guard let interface = configures[.networkInterface] else {
            context.console.print("インターフェイスが設定されていません。")
            return
        }

        let members = try await Member.query(on: context.application.db).all()
        if members.isEmpty {
            context.console.print("メンバーは登録されていません。")
            return
        }

        let output = try await SwiftCommand.Command(executablePath: .init(arpScan.value))
            .addArgument("-I")
            .addArgument(interface.value)
            .addArgument("-l")
            .output

        guard output.status.terminatedSuccessfully else {
            context.application.logger.error("arp-scanの実行に失敗しました。")
            return
        }

        let foundMacAddresses: Set<MacAddress> = .init(
            output.stdout
                .split(separator: "\n")
                .compactMap { MacAddress.extract(String($0)) }
        )

        let existingMemberNames =
            members
            .filter { foundMacAddresses.contains($0.macAddress) }
            .map(\.name)

        let response = try await context.application.client
            .post(.init(string: host.value), content: existingMemberNames)

        context.console.print("以下のメンバーが在宅です")
        for name in existingMemberNames {
            context.console.print("- \(name)")
        }

        guard response.status == .noContent else {
            context.application.logger.error("サーバーへの送信に失敗しました。")
            context.application.logger.error("Response Status: \(response.status)")
            let content = try response.content.decode(ErrorContent.self)
            context.application.logger.error("Response Content: \(content.reason)")
            return
        }

        context.application.logger.info("サーバーへの送信に成功しました。")
    }
}
