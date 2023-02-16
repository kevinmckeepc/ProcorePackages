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
            url: "https://www.dropbox.com/s/insdvjuekb4kp61/Eureka.zip?dl=1",
            checksum: "b7b5158be3eefb373691f0284bfb17ffb2b5f5566e973b6ccc43a0e2221235b5"
        )
    ]
)
