import Fluent

final class Interface: Model {

    static let schema = "interfaces"

    @ID
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    init() {}

    init(id: UUID = .init(), name: String) {
        self.id = id
        self.name = name
    }
}
