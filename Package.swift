// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "protoc-gen-swift_realm",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .executable(
            name: "protoc-gen-swift_realm",
            targets: ["protoc-gen-swift_realm"]),
    ],
    dependencies: [
        .package(url: "https://github.com/alexeyxo/protobuf-swift-generator-utils.git", from: "1.1.3"),
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "protoc-gen-swift_realm",
            dependencies: [ "ProtobufGeneratorUtils"],
            path: ".",
            sources: ["Sources"]
        )
//        .testTarget(
//            name: "protoc-gen-swift_realmTests",
//            dependencies: ["protoc-gen-swift_realm"]),
//            path: ".",
    ]
)
