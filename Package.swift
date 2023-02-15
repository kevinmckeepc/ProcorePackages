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
            name: "ProcorePackages",
            targets: ["Eureka"]
        )
    ],
    dependencies: [
    ],
    targets: [
        .binaryTarget(
            name: "Eureka",
            url: "https://www.dropbox.com/s/mx9g04jackfkjm3/Eureka.zip?dl=1",
            checksum: "21967467b5afa836bd0001b05ba5e9a05c28c16db32eb4d07cf60fe318274869"
        )
    ]
)
