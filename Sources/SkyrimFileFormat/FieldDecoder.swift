// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 08/02/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Bytes
import Foundation

protocol UnconstrainedDecodable {
    static func decode(bytes: Int, from: Decoder) throws -> Self
}

extension Array: UnconstrainedDecodable where Element: Decodable {
    static var elementSize: Int { return MemoryLayout<Element>.size }
    static func decode(bytes: Int, from decoder: Decoder) throws -> Array<Element> {
        var result = Self()
        let count = bytes / elementSize
        for _ in 0..<count {
            result.append(try Element(from: decoder))
        }
        return result
    }
}

class FieldDecoder: Decoder {
    enum Error: Swift.Error {
        case outOfData
        case badStringEncoding
    }
    
    let header: Field.Header
    var data: Bytes
    var index: Bytes.Index
    
    internal init(header: Field.Header, data: Bytes) {
        self.header = header
        self.data = data
        self.index = data.startIndex
        self.codingPath = []
        self.userInfo = [:]
    }
    
    func decode<T: Decodable>(_ kind: T.Type) -> T {
        do {
            return try T(from: self)
        } catch {
            fatalError("arse")
        }
    }
    
    func read(_ count: Int) throws -> ArraySlice<Byte> {
        let end = index.advanced(by: count)
        guard end <= data.endIndex else { throw Error.outOfData }

        let slice = data[index..<end]
        index = end
        return slice
    }
    
    func read(until: Byte)  throws -> ArraySlice<Byte> {
        guard let end = data.firstIndex(of: until) else { throw Error.outOfData }
        let slice = data[index..<end]
        index = end
        return slice
    }

    func readInt<T>(_ type: T.Type) throws -> T where T: FixedWidthInteger {
        let bytes = try read(MemoryLayout<T>.size)
        return try T(littleEndianBytes: bytes)
    }

    func readAll() -> ArraySlice<Byte> {
        return data[index...]
    }
    
    func remainingCount() -> Int {
        data.count - index
    }
    
    var codingPath: [CodingKey]
    
    var userInfo: [CodingUserInfoKey : Any]
    
    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        return KeyedDecodingContainer(KeyedContainer(for: self, path: codingPath))
    }
    
    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        return UnkeyedContainer(for: self)
    }
    
    func singleValueContainer() throws -> SingleValueDecodingContainer {
        return SingleValueContainer(for: self, path: codingPath)
    }
    
    class KeyedContainer<K>: KeyedDecodingContainerProtocol where K: CodingKey {
        typealias Key = K
        
        var codingPath: [CodingKey]
        let decoder: FieldDecoder
        
        init(for decoder: FieldDecoder, path: [CodingKey]) {
            self.decoder = decoder
            self.codingPath = path
        }

        var allKeys: [K] {
            return []
        }
        
        func contains(_ key: K) -> Bool {
            print("Contains \(key.stringValue)")
            fatalError("to do")
        }
        
        func decodeNil(forKey key: K) throws -> Bool {
            fatalError("to do")
        }
        
        func decode(_ type: Float.Type, forKey key: K) throws -> Float {
            let bytes = try decoder.read(MemoryLayout<Float>.size)
            let raw = try UInt32(littleEndianBytes: bytes)
            return Float(bitPattern: raw)
        }

        func decode(_ type: Int.Type, forKey key: K) throws -> Int {
            return try decoder.readInt(type)
        }

        func decode(_ type: Int8.Type, forKey key: K) throws -> Int8 {
            return try decoder.readInt(type)
        }

        func decode(_ type: Int16.Type, forKey key: K) throws -> Int16 {
            return try decoder.readInt(type)
        }

        func decode(_ type: Int32.Type, forKey key: K) throws -> Int32 {
            return try decoder.readInt(type)
        }

        func decode(_ type: Int64.Type, forKey key: K) throws -> Int64 {
            return try decoder.readInt(type)
        }

        func decode(_ type: UInt.Type, forKey key: K) throws -> UInt {
            return try decoder.readInt(type)
        }

        func decode(_ type: UInt8.Type, forKey key: K) throws -> UInt8 {
            return try decoder.readInt(type)
        }

        func decode(_ type: UInt16.Type, forKey key: K) throws -> UInt16 {
            return try decoder.readInt(type)
        }

        func decode(_ type: UInt32.Type, forKey key: K) throws -> UInt32 {
            return try decoder.readInt(type)
        }

        func decode(_ type: UInt64.Type, forKey key: K) throws -> UInt64 {
            return try decoder.readInt(type)
        }

        func decode<T>(_ type: T.Type, forKey key: K) throws -> T where T : Decodable {
            if let unconstrained = type as? UnconstrainedDecodable.Type {
                return try unconstrained.decode(bytes: decoder.remainingCount(), from: decoder) as! T
            }

            print("decoding  \(type) \(key)")
            fatalError("to do")
        }
        
        func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: K) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
            fatalError("to do")
        }
        
        func nestedUnkeyedContainer(forKey key: K) throws -> UnkeyedDecodingContainer {
            fatalError("to do")
        }
        
        func superDecoder() throws -> Decoder {
            fatalError("to do")
        }
        
        func superDecoder(forKey key: K) throws -> Decoder {
            fatalError("to do")
        }
    }

    class UnkeyedContainer: UnkeyedDecodingContainer {
        let decoder: FieldDecoder
        
        var codingPath: [CodingKey]
        
        var count: Int?
        
        var isAtEnd: Bool
        
        var currentIndex: Int

        init(for decoder: FieldDecoder) {
            self.decoder = decoder
            self.codingPath = []
            self.count = nil
            self.currentIndex = 0
            self.isAtEnd = false
        }

        func decode(_ type: String.Type) throws -> String {
            fatalError("to do")
        }
        
        func decode(_ type: Double.Type) throws -> Double {
            fatalError("to do")
        }
        
        func decode(_ type: Float.Type) throws -> Float {
            fatalError("to do")
        }
        
        func decode(_ type: Int.Type) throws -> Int {
            fatalError("to do")
        }
        
        func decode(_ type: Int8.Type) throws -> Int8 {
            fatalError("to do")
        }
        
        func decode(_ type: Int16.Type) throws -> Int16 {
            fatalError("to do")
        }
        
        func decode(_ type: Int32.Type) throws -> Int32 {
            fatalError("to do")
        }
        
        func decode(_ type: Int64.Type) throws -> Int64 {
            fatalError("to do")
        }
        
        func decode(_ type: UInt.Type) throws -> UInt {
            fatalError("to do")
        }
        
        func decode(_ type: UInt8.Type) throws -> UInt8 {
            fatalError("to do")
        }
        
        func decode(_ type: UInt16.Type) throws -> UInt16 {
            fatalError("to do")
        }
        
        func decode(_ type: UInt32.Type) throws -> UInt32 {
            fatalError("to do")
        }
        
        func decode(_ type: UInt64.Type) throws -> UInt64 {
            fatalError("to do")
        }
        
        func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
            fatalError("to do")
        }
        
        func decode(_ type: Bool.Type) throws -> Bool {
            fatalError("to do")
        }
        
        func decodeNil() throws -> Bool {
            fatalError("to do")
        }
        
        func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
            fatalError("to do")
        }
        
        func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
            fatalError("to do")
        }
        
        func superDecoder() throws -> Decoder {
            fatalError("to do")
        }
    }

    class SingleValueContainer: SingleValueDecodingContainer {
        var codingPath: [CodingKey]
        
        func decodeNil() -> Bool {
            fatalError("to do")
        }
        
        func decode(_ type: Bool.Type) throws -> Bool {
            fatalError("to do")
        }
        
        func decode(_ type: String.Type) throws -> String {
            let bytes = try decoder.read(until: 0)
            guard let string = String(bytes: bytes, encoding: .utf8) else { throw Error.badStringEncoding }
            return string
        }
        
        func decode(_ type: Double.Type) throws -> Double {
            fatalError("to do")
        }
        
        func decode(_ type: Float.Type) throws -> Float {
            fatalError("to do")
        }
        
        func decode(_ type: Int.Type) throws -> Int {
            return try decoder.readInt(type)
        }
        
        func decode(_ type: Int8.Type) throws -> Int8 {
            return try decoder.readInt(type)
        }
        
        func decode(_ type: Int16.Type) throws -> Int16 {
            return try decoder.readInt(type)
        }
        
        func decode(_ type: Int32.Type) throws -> Int32 {
            return try decoder.readInt(type)
        }
        
        func decode(_ type: Int64.Type) throws -> Int64 {
            return try decoder.readInt(type)
        }
        
        func decode(_ type: UInt.Type) throws -> UInt {
            return try decoder.readInt(type)
        }
        
        func decode(_ type: UInt8.Type) throws -> UInt8 {
            return try decoder.readInt(type)
        }
        
        func decode(_ type: UInt16.Type) throws -> UInt16 {
            return try decoder.readInt(type)
        }
        
        func decode(_ type: UInt32.Type) throws -> UInt32 {
            return try decoder.readInt(type)
        }
        
        func decode(_ type: UInt64.Type) throws -> UInt64 {
            return try decoder.readInt(type)
        }
        
        func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
            fatalError("to do")
        }
        
        let decoder: FieldDecoder

        init(for decoder: FieldDecoder, path: [CodingKey]) {
            self.decoder = decoder
            self.codingPath = path
        }
    }

}
