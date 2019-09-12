// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "FriendlyDIKit",
    products: [
        .library(name: "FriendlyDIKit", targets:["FriendlyDIKit"])
    ],
    targets: [
        .target(name: "FriendlyDIKit", path: "Sources")
    ]
)
