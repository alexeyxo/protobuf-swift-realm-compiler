# Protobuf Swift Realm Compiler

Make it possible to generate Realm objects in Swift in according to your Protocol Buffers schemes. There is a runtime library for working with generated objects, for more information: [Protobuf Swift Realm](https://github.com/alexeyxo/protobuf-swift-realm)

#### Required [Protocol Buffers for Swift](https://github.com/alexeyxo/protobuf-swift)

## How To Install

1.`git clone "https://github.com/alexeyxo/protobuf-swift-realm-compiler.git" && cd protobuf-swift-realm-compiler`

2.`make install`

## How To Use

`protoc -I <FILENAME>.proto --swift_realm_out="./<OUT_DIR>"`