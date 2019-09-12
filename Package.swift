//
//  Package.swift
//  FriendlyDIKit
//
//  Created by spsadmin on 9/11/19.
//

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
