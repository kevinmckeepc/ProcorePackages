// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ProcorePackages",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "Eureka",
            targets: ["Eureka"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/realm/SwiftLint.git", branch: "main"),
    ],

    targets: [
        .binaryTarget(
            name: "Eureka",
            url: "https://www.dropbox.com/s/7urvzkbqrsaimrr/Eureka.zip?dl=1",
            checksum: "bde687c446feca3e3584d39e9d7e9cb384e6a0026b1acdd7b0218e21ed12b2d8"
        ),
        .testTarget(
            name: "EurekaTests",
            dependencies: ["Eureka"]
        )
    ]
)
