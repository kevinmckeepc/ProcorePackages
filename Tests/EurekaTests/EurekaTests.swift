import XCTest
import Eureka

final class ProcorePackagesTests: XCTestCase {
    
    func testEureka() throws {
        
        let textRow = TextRow()
        textRow.value = "Hello"
        XCTAssertNotNil(textRow.value)
        
        let urlRow = URLRow()
        urlRow.value = URL(string: "https://www.procore.com")
        XCTAssertNotNil(urlRow.value)
    }
}
