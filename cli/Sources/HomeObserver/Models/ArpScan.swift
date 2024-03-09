import Fluent

final class ArpScan: Model {

    static let schema = "arp_scans"

    @ID
    var id: UUID?

    @Field(key: "path")
    var path: String

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    init() {}

    init(id: UUID = .init(), path: String) {
        self.id = id
        self.path = path
    }
}
