import XCTest
import nmbr

final class NMBRTests: XCTestCase {

    // MARK: Small numbers (i.e. less than the first grouping separator)

    func testSmallNumber_UK() {
        let formatter = NMBRFormatter()
        formatter.locale = Locale(identifier: "en_GB")
        formatter.outputFormat = .short

        XCTAssertEqual("0", formatter.format(0))
        XCTAssertEqual("1", formatter.format(1))
        XCTAssertEqual("999", formatter.format(999))
    }

    func testSmallNumber_India() {
        let formatter = NMBRFormatter()
        formatter.locale = Locale(identifier: "en_IN")
        formatter.outputFormat = .short

        XCTAssertEqual("0", formatter.format(0))
        XCTAssertEqual("1", formatter.format(1))
        XCTAssertEqual("999", formatter.format(999))
    }

    func testSmallNumber_ZH() {
        let formatter = NMBRFormatter()
        formatter.locale = Locale(identifier: "zh")
        formatter.precision = 0
        formatter.outputFormat = .short

        XCTAssertEqual("0", formatter.format(0))
        XCTAssertEqual("1", formatter.format(1))
        XCTAssertEqual("999", formatter.format(999))
        XCTAssertEqual("9999", formatter.format(9999))
    }

    // MARK: Long numbers (greater or equal to the first grouping separator)

    func testLargeNumber_Long_UK() {
        let formatter = NMBRFormatter()
        formatter.locale = Locale(identifier: "en_GB")
        formatter.outputFormat = .long

        XCTAssertEqual("1 thousand", formatter.format(1000))
        XCTAssertEqual("1.1 thousand", formatter.format(1100))
    }

    func testLargeNumber_Short_UK() {
        let formatter = NMBRFormatter()
        formatter.locale = Locale(identifier: "en_GB")
        formatter.outputFormat = .short

        XCTAssertEqual("1K", formatter.format(1000))
        XCTAssertEqual("1.1K", formatter.format(1100))
    }
}

final class NMBRPrecisionTests: XCTestCase {

    func testSmallNumbers() {
        let formatter = NMBRFormatter()
        formatter.precision = 2

        XCTAssertEqual("1", formatter.format(1))
        XCTAssertEqual("1", formatter.format(1.0))
        XCTAssertEqual("1.1", formatter.format(1.1))
        XCTAssertEqual("1.12", formatter.format(1.12))
        XCTAssertEqual("1.12", formatter.format(1.123))
        XCTAssertEqual("1.12", formatter.format(1.1234))
    }

    func testLargeNumbers() {
        let formatter = NMBRFormatter()
        formatter.precision = 1

        XCTAssertEqual("1K", formatter.format(1000))
        XCTAssertEqual("1.1K", formatter.format(1100))
        XCTAssertEqual("1.1K", formatter.format(1110))
        XCTAssertEqual("1.1K", formatter.format(1149))
        XCTAssertEqual("1.2K", formatter.format(1151))
    }
}
