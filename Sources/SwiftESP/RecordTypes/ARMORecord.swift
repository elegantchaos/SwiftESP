// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 02/02/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import BinaryCoding
import Bytes
import Foundation

public struct ARMORecord: Codable, IdentifiedRecord {
  public static var tag = Tag("ARMO")

  public let _meta: RecordMetadata

  public let editorID: String?
  public let bounds: OBNDField
  public let fullName: String?
  public let enchantment: FormID?
  public let enchantmentAmount: UInt16?
  public let maleArmour: String
  public let maleModelData: MODTField?
  public let maleTextures: AlternateTextureField?
  public let maleInventoryImage: String?
  public let maleMessageImage: String?
  public let femaleArmour: String?
  public let femaleModelData: MODTField?
  public let femaleTextures: AlternateTextureField?
  public let femaleInventoryImage: String?
  public let femaleMessageImage: String?
  public let bodyTemplate: BOD2Field
  public let pickupSound: FormID
  public let dropSound: FormID
  public let equipSlot: FormID?
  public let bashImpactDataSet: FormID?
  public let bashMaterial: FormID?
  public let race: FormID
  public let keywordCount: UInt32
  public let keywords: SingleFieldArray<FormID>
  public let desc: String
  public let armature: [FormID]
  public let data: DATAField
  public let armourRating: UInt32
  public let template: FormID?

  public static var fieldMap = FieldTypeMap(paths: [
    (CodingKeys.editorID, \Self.editorID, "EDID"),
    (.bounds, \.bounds, "OBND"),
    (.fullName, \.fullName, "FULL"),
    (.enchantment, \.enchantment, "EITM"),
    (.enchantmentAmount, \.enchantmentAmount, "EAMT"),
    (.maleArmour, \.maleArmour, "MOD2"),
    (.maleModelData, \.maleModelData, "MO2T"),
    (.maleTextures, \.maleTextures, "MO2S"),
    (.maleInventoryImage, \.maleInventoryImage, "ICON"),
    (.maleMessageImage, \.maleMessageImage, "MICO"),
    (.femaleArmour, \.femaleArmour, "MOD4"),
    (.femaleModelData, \.femaleModelData, "MO4T"),
    (.femaleTextures, \.femaleTextures, "MO4S"),
    (.femaleInventoryImage, \.femaleInventoryImage, "ICO2"),
    (.femaleMessageImage, \.femaleMessageImage, "MIC2"),
    (.bodyTemplate, \.bodyTemplate, "BOD2"),
    (.pickupSound, \.pickupSound, "YNAM"),
    (.dropSound, \.dropSound, "ZNAM"),
    (.equipSlot, \.equipSlot, "ETYP"),
    (.bashImpactDataSet, \.bashImpactDataSet, "BIDS"),
    (.bashMaterial, \.bashMaterial, "BAMT"),
    (.race, \.race, "RNAM"),
    (.keywordCount, \.keywordCount, "KSIZ"),
    (.keywords, \.keywords, "KWDA"),
    (.desc, \.desc, "DESC"),
    (.armature, \.armature, "MODL"),
    (.data, \.data, "DATA"),
    (.armourRating, \.armourRating, "DNAM"),
    (.template, \.template, "TNAM"),
  ])

  public struct DATAField: BinaryCodable {
    let base: UInt32
    let weight: Float
  }
}
