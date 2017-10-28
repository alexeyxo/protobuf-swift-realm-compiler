//
//  GeneratorOneof.swift
//  protoc-gen-swift_reactnew
//
//  Created by Alexey Khokhlov on 20.10.2017.
//

import Foundation
import ProtocolBuffers
import ProtobufGeneratorUtils

class GeneratorOneof: ThreeDescriptorGenerator<Google.Protobuf.OneofDescriptorProto, Google.Protobuf.DescriptorProto> {
    var file:GeneratorFile
    init(file:GeneratorFile, descriptor: Google.Protobuf.OneofDescriptorProto, writer: CodeWriter, parentGenerator:GeneratorMessage? = nil) {
        self.file = file
        super.init(descriptor: descriptor, writer: writer)
        self.parentGenerator = parentGenerator
    }
    required init(descriptor: GeneratedDescriptorType, writer: CodeWriter) {
        fatalError("init(descriptor:writer:) has not been implemented")
    }
    func generateSource() {

    }
    func generateExtensions() {
//        self.descriptor.name
    }
    func protoClassName() -> String {
        var fullName = ""
        if self.writer.file.hasPackage {
            fullName += self.writer.file.package + "."
        }
        var parent = self.parentGenerator
        while parent != nil {
            fullName += (self.parentGenerator?.descriptor.name)! + "."
            parent = parent?.parentGenerator
        }
        fullName += self.descriptor.name + "."
        return fullName.capitalizedCamelCase()
    }
}

