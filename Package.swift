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
            url: "https://www.dropbox.com/s/2gogik5nqixgp2n/Eureka.zip?dl=1",
            checksum: "58ba877df2c64cf4a921c6b76b860d31c225c900495d0c9dc48cc6883b054829"
        )
    ]
)
