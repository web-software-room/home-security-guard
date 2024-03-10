import RegexBuilder

/// MACアドレスの値オブジェクト.
final class MacAddress: Sendable {

    /// MACアドレスの文字列.
    ///
    /// 例: "01:32:f4:67:89:ab".
    ///
    /// - Note: 小文字で初期化される
    let raw: String

    /// MACアドレスとして文字列が正しい場合のみ初期化可能.
    /// - Parameter raw: MACアドレスの文字列
    /// - Throws: rawが正しい形式でない場合、`MacAddress.InvalidError`が投げられる
    init(_ raw: String) throws {
        let lowerCased = raw.lowercased()
        guard let matched = try Self.macAddressRegex.firstMatch(in: lowerCased)?.0,
            matched == lowerCased
        else {
            throw InvalidError(raw)
        }
        self.raw = String(matched)
    }

    private static let hexRegex = CharacterClass(("0"..."9"), ("a"..."f"))
    private static let numRegex = Regex {
        hexRegex
        hexRegex
    }
    private static let macAddressRegex = Regex {
        Capture {
            numRegex
            ":"
            numRegex
            ":"
            numRegex
            ":"
            numRegex
            ":"
            numRegex
            ":"
            numRegex
        }
    }
}

extension MacAddress: Equatable {
    static func == (lhs: MacAddress, rhs: MacAddress) -> Bool {
        lhs.raw == rhs.raw
    }
}

extension MacAddress: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(raw)
    }
}

extension MacAddress {
    /// MACアドレスの初期化時に形式が正しくない場合に投げられるError.
    struct InvalidError: Error, Hashable, Sendable {
        let raw: String

        init(_ raw: String) {
            self.raw = raw
        }
    }
}

extension MacAddress: CustomStringConvertible {
    var description: String {
        raw
    }
}

extension MacAddress {
    /// 1行の文字列からMACアドレスを抽出する.
    /// - Parameter line: MACアドレスが1つ含まれるかもしれない1行の文字列
    /// - Returns: MACアドレスが含まれる場合はその値、含まれない場合はnil
    static func extract(_ line: String) -> Self? {
        guard let matched = try? macAddressRegex.firstMatch(in: line.lowercased())?.0 else {
            return nil
        }
        return try? .init(String(matched))
    }
}
