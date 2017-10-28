// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "protoc-gen-swift_realm",
    dependencies: [
        .Package(url: "https://github.com/alexeyxo/protobuf-swift.git", majorVersion: 3),
        .Package(url: "https://github.com/alexeyxo/protobuf-swift-generator-utils.git", majorVersion: 1)
    ]
)
