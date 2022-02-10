// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 01/02/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

struct TES4Record: Codable, RecordProtocol {
    static var tag = Tag("TES4")
    
    let header: RecordHeader
    let info: TES4Header
    var desc: String?
    let author: String?
    let masters: [String]
    let masterData: [UInt64]
    let tagifiedStringCount: UInt32
    let unknownCounter: UInt32?
    let fields: [UnpackedField]?
    
    func asJSON(with processor: Processor) throws -> Data {
        return try processor.encoder.encode(self)
    }
    
    static var fieldMap = FieldTypeMap(paths: [
        (CodingKeys.info, \Self.info, "HEDR"),
        (.author, \.author, "CNAM"),
        (.desc, \.desc, "SNAM"),
        (.masters, \.masters, "MAST"),
        (.masterData, \.masterData, "DATA"),
        (.tagifiedStringCount, \.tagifiedStringCount, "INTV"),
        (.unknownCounter, \.unknownCounter, "INTC")
    ])
}

extension TES4Record: CustomStringConvertible {
    var description: String {
        return "«TES4 \(info.version)»"
    }
}
