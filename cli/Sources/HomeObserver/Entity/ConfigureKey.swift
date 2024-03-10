/// 設定項目のキー.
enum ConfigureKey: String, Hashable, Codable, Sendable, CaseIterable {
    /// arp-scanコマンドのpath
    case arpScanPath
    /// APIサーバーのアドレス
    case apiServerHostAddress
    /// arp-scanで使用する対象ネットワークインターフェイス
    case networkInterface
}
