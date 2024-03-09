import Fluent

final class Member: Model {

    static let schema = "members"

    @ID
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "mac_address")
    var macAddress: String

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    init() {}

    init(id: UUID = .init(), name: String, macAddress: String) {
        self.id = id
        self.name = name
        self.macAddress = macAddress
    }
}
