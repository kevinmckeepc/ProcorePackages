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
            url: "https://www.dropbox.com/s/2slrhm7lhgl6hsw/Eureka.zip?dl=1",
            checksum: "8c4507b9b77ae05a3fed313fe857aa5dd9a154a94a2737346c38efb99e313867"
        )
    ]
)
