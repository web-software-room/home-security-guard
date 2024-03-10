import Fluent

final class Member: Model {

    static let schema = "members"

    @ID
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "mac_address")
    var rawMacAddress: String

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    init() {}

    init(id: UUID = .init(), name: String, macAddress: MacAddress) {
        self.id = id
        self.name = name
        self.rawMacAddress = macAddress.raw
    }
}

extension Member {
    var macAddress: MacAddress {
        get {
            try! MacAddress(rawMacAddress)
        }
        set {
            rawMacAddress = newValue.raw
        }
    }
}
