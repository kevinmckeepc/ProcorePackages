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
        .package(url: "https://github.com/realm/SwiftLint.git", branch: "main"),
    ],
    targets: [
        .binaryTarget(
            name: "Eureka",
            url: "https://www.dropbox.com/s/h0s4nm2awuy2ea2/Eureka.zip?dl=1",
            checksum: "2b14a10e644caa573334e13afe23d6bdd54e9ce4e4285c1ff65e1c80ea15da7d"
        )
    ]
)
