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
            url: "https://www.dropbox.com/s/0der7fwshsbnsxw/Eureka.zip?dl=1",
            checksum: "d02fed7f9cf1e409520749d37cab0ea6923ec9b35ba8693af4d77de6ffe41709"
        )
    ]
)
