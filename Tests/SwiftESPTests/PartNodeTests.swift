// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 11/02/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import SwiftCreationKitCommon
import XCTest

@testable import SwiftESP

class PartNodeTests: XCTestCase {
    func testRoundtrip() throws {
        let partNode: PartFlags = [.head, .leg_left, .body]
        let encoder = JSONEncoder()
        let data = try encoder.encode(partNode)
        
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(PartFlags.self, from: data)
        XCTAssertEqual(partNode, decoded)
    }
}
