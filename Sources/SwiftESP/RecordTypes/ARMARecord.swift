// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 14/02/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import BinaryCoding
import Foundation

public struct ARMARecord: IdentifiedRecord {
  public static var tag = Tag("ARMA")

  public let _meta: RecordMetadata

  public let editorID: String?
  public let bodyTemplate: BOD2Field
  public let primaryRace: FormID
  public let unknown: DNAMField
  public let model2: String
  public let model2Textures: MODTField?
  public let model2AlternateTextures: [AlternateTextureField]
  public let model3: String?
  public let model3Textures: MODTField?
  public let model3AlternateTextures: [AlternateTextureField]
  public let model4: String?
  public let model4Textures: MODTField?
  public let model4AlternateTextures: [AlternateTextureField]
  public let model5: String?
  public let model5Textures: MODTField?
  public let model5AlternateTextures: [AlternateTextureField]
  public let baseMaleTexture: FormID?
  public let baseFemaleTexture: FormID?
  public let baseMaleFirstPersonTexture: FormID?
  public let baseFemaleFirstPersonTexture: FormID?
  public let races: [FormID]
  public let footstepSound: FormID?
  public let artObject: FormID?

  public static var fieldMap = FieldTypeMap(paths: [
    (CodingKeys.editorID, \Self.editorID, "EDID"),
    (.bodyTemplate, \.bodyTemplate, "BOD2"),
    (.primaryRace, \.primaryRace, "RNAM"),
    (.unknown, \.unknown, "DNAM"),
    (.model2, \.model2, "MOD2"),
    (.model2Textures, \.model2Textures, "MO2T"),
    (.model2AlternateTextures, \.model2AlternateTextures, "MO2S"),
    (.model3, \.model3, "MOD3"),
    (.model3Textures, \.model3Textures, "MO3T"),
    (.model3AlternateTextures, \.model3AlternateTextures, "MO3S"),
    (.model4, \.model4, "MOD4"),
    (.model4Textures, \.model4Textures, "MO4T"),
    (.model4AlternateTextures, \.model4AlternateTextures, "MO4S"),
    (.model5, \.model5, "MOD5"),
    (.model5Textures, \.model5Textures, "MO5T"),
    (.model5AlternateTextures, \.model5AlternateTextures, "MO5S"),
    (.baseMaleTexture, \.baseMaleTexture, "NAM0"),
    (.baseFemaleTexture, \.baseFemaleTexture, "NAM1"),
    (.baseMaleFirstPersonTexture, \.baseMaleFirstPersonTexture, "NAM2"),
    (.baseFemaleFirstPersonTexture, \.baseFemaleFirstPersonTexture, "NAM3"),
    (.races, \.races, "MODL"),
    (.footstepSound, \.footstepSound, "SNDD"),
    (.artObject, \.artObject, "ONAM"),
  ])

  public struct DNAMField: BinaryCodable {
    let malePriority: UInt8
    let femalePriority: UInt8
    let unknown: UInt32
    let detectionSound: UInt8
    let unknown2: UInt8
    let weaponAdjust: Float32
  }
}
