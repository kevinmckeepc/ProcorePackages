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
            url: "https://www.dropbox.com/s/0lpmz839yw7sr1n/Eureka.zip?dl=1",
            checksum: "3330d446632806fd5c6c2f4bf9caa16edb448cf6cf5775955012e49574fb01ef"
        )
    ]
)
