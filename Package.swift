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
//        .binaryTarget(
//            name: "Eureka",
//            path: "Scripts/Build/Eureka.xcframework"
//        ),
        .binaryTarget(
            name: "Eureka",
            url: "https://www.dropbox.com/s/8qsmqqkte8synhz/Eureka.zip?dl=1",
            checksum: "8696a079946731b8e33f4c8af90199e6d83c8829ce3fd6e93155f8fb805c7506"
        ),
        .testTarget(
            name: "EurekaTests",
            dependencies: ["Eureka"]
        )
    ]
)
