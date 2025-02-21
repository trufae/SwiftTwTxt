// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "YarnTwix",
    platforms: [
        .macOS(.v12), .iOS(.v15)
    ],
    products: [
        .executable(name: "YarnTwix", targets: ["YarnTwix"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "YarnTwix",
            dependencies: []
//            resources: [.process("Resources")]
        )
    ]
)
