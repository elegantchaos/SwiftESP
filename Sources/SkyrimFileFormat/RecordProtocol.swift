// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 10/02/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

protocol RecordProtocol: Codable, CustomStringConvertible {
    static var tag: Tag { get }
    func asJSON(with processor: Processor) throws -> Data
    static func fromJSON(_ data: Data, with processor: Processor) throws -> RecordProtocol
    static var fieldMap: FieldTypeMap { get }
    var _header: RecordHeader { get }
    var _children: [RecordProtocol] { get } // TODO: make this an iterator so that we can defer loading of children
}

extension RecordProtocol {
    var type: Tag { _header.type }
    
    var header: RecordHeader { _header }

    func asJSON(with processor: Processor) throws -> Data {
        return try processor.jsonEncoder.encode(self)
    }
    
    static func fromJSON(_ data: Data, with processor: Processor) throws -> RecordProtocol {
        let decoded = try processor.jsonDecoder.decode(Self.self, from: data)
        return decoded
    }
    
    var _children: [RecordProtocol] { [] }
}

extension RecordProtocol {
    var description: String {
        "«\(type)»"
    }
}

protocol IdentifiedRecord: RecordProtocol {
    var editorID: String { get }
}
