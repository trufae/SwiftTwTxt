// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "TwtxtClient",
    platforms: [
        .macOS(.v12), .iOS(.v15)
    ],
    products: [
        .executable(name: "TwtxtClient", targets: ["TwtxtClient"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "TwtxtClient",
            dependencies: []
//            resources: [.process("Resources")]
        )
    ]
)
