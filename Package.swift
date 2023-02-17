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
            url: "https://www.dropbox.com/s/tb1u7k1ufw23coo/Eureka.zip?dl=1",
            checksum: "22eecf22040125057b03905d934b30f95a82eae7b24f6de36e2594edf9dd42b8"
        )
    ]
)
