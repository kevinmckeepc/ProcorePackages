import XCTest
import Eureka

final class EurekaTests: XCTestCase {
    
    func testEureka() throws {
        
        let textValue = "Procore"
        let textRow = TextRow()
        textRow.value = textValue
        XCTAssertEqual(textRow.value, textValue)
        
        let urlValue = URL(string: "https://www.procore.com")
        let urlRow = URLRow()
        urlRow.value = urlValue
        XCTAssertEqual(urlRow.value, urlValue)
    }
}
