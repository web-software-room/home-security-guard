import Fluent
import Foundation

/// 設定を保存しておくKey-Valueモデル.
final class Configure: Model {

    static let schema = "configures"

    @ID
    var id: UUID?

    @Enum(key: "key")
    var key: ConfigureKey

    @Field(key: "value")
    var value: String

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    init() {}

    init(id: UUID = .init(), key: ConfigureKey, value: String) {
        self.id = id
        self.key = key
        self.value = value
    }
}

extension Configure {
    /// keyを指定してDBからその設定を取得する.
    /// - Parameters:
    ///   - key: 取得したい設定のキー
    ///   - db: データベース
    /// - Throws: データベースエラー
    /// - Returns: 指定されたキーに対応する設定。未設定の場合はnilを返す
    static func find(key: ConfigureKey, on db: any Database) async throws -> Configure? {
        try await query(on: db)
            .filter(\.$key == key)
            .first()
    }
}
