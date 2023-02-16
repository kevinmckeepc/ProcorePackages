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
            url: "https://www.dropbox.com/s/oapfnqm2bqcljeh/Eureka.zip?dl=1",
            checksum: "ff1922606fdb1617e840bc9f0a9d1aef0e23d13e701e3b933e569b7132c6cb7d"
        )
    ]
)
