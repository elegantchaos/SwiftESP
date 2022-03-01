// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 16/02/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import BinaryCoding
import Foundation

struct ESPBundle {
    typealias Index = [Tag:[RecordProtocol]]
    
    let name: String
    var records: [RecordProtocol]
    var allRecords: [RecordProtocol]
    var index: Index
    var count: Int { records.count }
    var header: TES4Record? {
        records.first(where: { $0.type == TES4Record.tag }) as? TES4Record
    }
    
    init(name: String, records: [RecordProtocol]) {
        var index = Index()
        var ordered: [RecordProtocol] = []

        func register(_ record: RecordProtocol) {
            var list = index[record.type] ?? []
            list.append(record)
            index[record.type] = list
            ordered.append(record)
        }

        for record in records {
            register(record)
            for child in record._children {
                register(child)
            }
        }
        
        self.name = name
        self.records = records
        self.allRecords = ordered
        self.index = index
    }
    
}
