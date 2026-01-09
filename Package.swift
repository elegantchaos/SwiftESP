// swift-tools-version:5.11

// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 31/01/2022.
//  All code (c) 2022 - present day, Elegant Chaos.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import PackageDescription

let package = Package(
  name: "SwiftESP",
  platforms: [
    .macOS(.v12)
  ],
  products: [
    .library(
      name: "SwiftESP",
      targets: ["SwiftESP"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/mochidev/AsyncSequenceReader.git", from: "0.3.1"),
    .package(url: "https://github.com/elegantchaos/BinaryCoding.git", from: "1.0.5"),
    .package(url: "https://github.com/elegantchaos/Bytes.git", from: "0.3.3"),
    .package(url: "https://github.com/elegantchaos/Coercion.git", from: "1.1.3"),
    .package(url: "https://github.com/elegantchaos/ElegantStrings.git", from: "1.1.1"),
    .package(url: "https://github.com/elegantchaos/Expressions.git", from: "1.1.1"),
    .package(url: "https://github.com/elegantchaos/Logger.git", from: "1.7.3"),
    .package(url: "https://github.com/tsolomko/SWCompression.git", .upToNextMajor(from: "4.8.0")),
    .package(url: "https://github.com/elegantchaos/SwiftCreationEngineCommon.git", from: "1.0.2"),
    .package(url: "https://github.com/elegantchaos/XCTestExtensions.git", from: "1.4.6"),
  ],

  targets: [
    .target(
      name: "SwiftESP",
      dependencies: [
        "AsyncSequenceReader",
        "BinaryCoding",
        "Bytes",
        "Coercion",
        "ElegantStrings",
        "Expressions",
        "Logger",
        .product(name: "SWCompression", package: "SWCompression"),
        "SwiftCreationEngineCommon",
      ],
      resources: []
    ),

    .testTarget(
      name: "SwiftESPTests",
      dependencies: [
        "SwiftCreationEngineCommon",
        "SwiftESP",
        "XCTestExtensions",
      ],

      resources: [
        .process("Resources/Examples/"),
        .copy("Resources/Unpacked"),
      ]
    ),
  ]
)
