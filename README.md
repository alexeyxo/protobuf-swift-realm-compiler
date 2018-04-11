# Protobuf Swift Realm Compiler

Make it possible to generate Realm objects in Swift in according to your Protocol Buffers schemes. There is a runtime library for working with generated objects, for more information: [Protobuf Swift Realm](https://github.com/alexeyxo/protobuf-swift-realm)

#### Required [Protocol Buffers for Swift](https://github.com/alexeyxo/protobuf-swift)

## How To Install

1.`git clone "https://github.com/alexeyxo/protobuf-swift-realm-compiler.git" && cd protobuf-swift-realm-compiler`

2.`make install`

## How To Use

`protoc -I ./<DESC_DIR> ./<FILENAME>.proto --swift_realm_out="./<OUT_DIR>"`

* **DESC_DIR**: path to folder that contains `/google/protobuf/descriptor.proto` & `/google/protobuf/swift-descriptor.proto`
* **FILENAME.proto**: path to your protobuf models, it's possible to set `*.proto` for getting all proto files
* **OUT_DIR**: output path for generated files

### Example

**Directory structure (/project)**:
* /protobuf
    * /google/protobuf
        * /descriptor.proto
        * /swift-descriptor.proto
    * /Employee.proto
* /ios
    * /ProtoApi.Employee.realm.swift
 
**Run command**:

`cd project && protoc -I ./protobuf ./protobuf/Employee.proto --swift_realm_out="./ios"`
