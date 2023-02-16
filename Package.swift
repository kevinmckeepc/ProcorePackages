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
            url: "https://www.dropbox.com/s/l3c3wmlms0i8inq/Eureka.zip?dl=1",
            checksum: "10752882941cda24aaf6216dd58d887cf8b5e7ac89452948d4c23e789f0a1451"
        )
    ]
)
