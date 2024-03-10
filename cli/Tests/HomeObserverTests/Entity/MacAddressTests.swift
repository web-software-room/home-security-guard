import XCTest

@testable import HomeObserver

final class MacAddressTests: XCTestCase {

    func test小文字だとそのまま初期化される() throws {
        let raw = "01:32:f4:67:89:ab"

        let macAddress = try MacAddress(raw)

        XCTAssertEqual(macAddress.raw, "01:32:f4:67:89:ab")
    }

    func test大文字だと初期化時に小文字にされる() throws {
        let raw = "01:32:F4:67:89:AB"

        let macAddress = try MacAddress(raw)

        XCTAssertEqual(macAddress.raw, "01:32:f4:67:89:ab")
    }

    func testコロンなしでは初期化できない() throws {
        XCTAssertThrowsError(try MacAddress("0132546789AB")) { error in
            XCTAssertEqual(error as? MacAddress.InvalidError, .init("0132546789AB"))
        }
    }

    func testコロンは5個必要() throws {
        XCTAssertThrowsError(try MacAddress("01:32:54:67:89")) { error in
            XCTAssertEqual(error as? MacAddress.InvalidError, .init("01:32:54:67:89"))
        }
    }

    func testGからZは使用できない() throws {
        XCTAssertThrowsError(try MacAddress("01:32:54:67:89:GG")) { error in
            XCTAssertEqual(error as? MacAddress.InvalidError, .init("01:32:54:67:89:GG"))
        }
    }

    func testMACアドレス以外は混入してはいけない() throws {
        XCTAssertThrowsError(try MacAddress(" 01:32:f4:67:89:ab")) { error in
            XCTAssertEqual(error as? MacAddress.InvalidError, .init(" 01:32:f4:67:89:ab"))
        }
    }
}
