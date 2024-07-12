import XCTest
import OSLog
import Foundation
@testable import Scrumskipper

let logger: Logger = Logger(subsystem: "Scrumskipper", category: "Tests")

@available(macOS 13, *)
final class ScrumskipperTests: XCTestCase {
    func testScrumskipper() throws {
        logger.log("running testScrumskipper")
        XCTAssertEqual(1 + 2, 3, "basic test")
        
        // load the TestData.json file from the Resources folder and decode it into a struct
        let resourceURL: URL = try XCTUnwrap(Bundle.module.url(forResource: "TestData", withExtension: "json"))
        let testData = try JSONDecoder().decode(TestData.self, from: Data(contentsOf: resourceURL))
        XCTAssertEqual("Scrumskipper", testData.testModuleName)
    }
}

struct TestData : Codable, Hashable {
    var testModuleName: String
}