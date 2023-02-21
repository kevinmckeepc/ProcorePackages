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
            url: "https://www.dropbox.com/s/rxihz8y268edfco/Eureka.zip?dl=1",
            checksum: "26001cc2fb82daee4a219dce643ece3d1dd92d1f4a8101be58ddf7bf9251abec"
        ),
        .testTarget(
            name: "EurekaTests",
            dependencies: ["Eureka"]
        )
    ]
)
