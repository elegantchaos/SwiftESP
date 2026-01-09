// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 10/02/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import BinaryCoding
import Foundation
import SwiftCreationEngineCommon

public struct BOD2Field: BinaryCodable {
    let partFlags: PartFlags
    let armorType: ArmorType

    enum ArmorType: String, DecodableFromIntOrString {
        case light
        case heavy
        case clothing
    }
}

extension BOD2Field: Equatable {
}
