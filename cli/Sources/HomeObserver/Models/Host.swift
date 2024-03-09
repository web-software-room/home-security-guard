import Fluent

final class Host: Model {

    static let schema = "hosts"

    @ID
    var id: UUID?

    @Field(key: "address")
    var address: String

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    init() {}

    init(id: UUID = .init(), address: String) {
        self.id = id
        self.address = address
    }
}
