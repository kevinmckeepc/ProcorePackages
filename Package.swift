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
            url: "https://www.dropbox.com/s/vqevdcs0bg87t2z/Eureka.zip?dl=1",
            checksum: "4702d4de22e38455b448e2a77e5d52dcc57196734c23c9351645d81a1e6624f7"
        ),
        .testTarget(
            name: "EurekaTests",
            dependencies: ["Eureka"]
        )
    ]
)
