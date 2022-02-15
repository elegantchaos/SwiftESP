// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 09/02/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Bytes
import Foundation

struct RecordHeader: Codable {
    let flags: UInt32?
    let id: UInt32?
    let timestamp: UInt16?
    let versionInfo: UInt16?
    let version: UInt16?
    let unused: UInt16?
    
    init() {
        self.flags = nil
        self.id = nil
        self.timestamp = nil
        self.versionInfo = nil
        self.version = nil
        self.unused = nil
    }
    
    init(_ stream: DataStream) async throws {
        self.flags = try await stream.readNonZero(UInt32.self)
        self.id = try await stream.readNonZero(UInt32.self)
        self.timestamp = try await stream.readNonZero(UInt16.self)
        self.versionInfo = try await stream.readNonZero(UInt16.self)
        self.version = try await stream.read(UInt16.self, not: 44)
        self.unused = try await stream.readNonZero(UInt16.self)
    }
}

extension RecordHeader: BinaryEncodable {
    func binaryEncode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(flags ?? 0)
        try container.encode(id ?? 0)
        try container.encode(timestamp ?? 0)
        try container.encode(versionInfo ?? 0)
        try container.encode(version ?? 44)
        try container.encode(unused ?? 0)
    }
}
