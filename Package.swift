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
            url: "https://www.dropbox.com/s/2fnel1oba6zqofh/Eureka.zip?dl=1",
            checksum: "61b1f3b59fdd1340c3f3bdd44f90bba3761ecfc3246c0b80356ebd7729ad380e"
        )
    ]
)
