//
//  GeneratorField.swift
//  protobuf-swift-realm-runtimePackageDescription
//
//  Created by Alexey Khokhlov on 18.10.2017.
//

import Foundation
import ProtocolBuffers
import ProtobufGeneratorUtils
final class GeneratorFields: ThreeDescriptorGenerator<Google.Protobuf.FieldDescriptorProto, Google.Protobuf.DescriptorProto>, CodeGeneratorMethods {
    var file:GeneratorFile
    init(file:GeneratorFile, descriptor: Google.Protobuf.FieldDescriptorProto, writer: CodeWriter, parentGenerator:GeneratorMessage) {
        self.file = file
        super.init(descriptor: descriptor, writer: writer)
        self.parentGenerator = parentGenerator
    }
    
    required init(descriptor: GeneratedDescriptorType, writer: CodeWriter) {
        fatalError("init(descriptor:writer:) has not been implemented")
    }
    
    func generateSource() {
        if let parent = self.parentGenerator, IsMapEntry(parent.descriptor) {
            GeneratorMapFields(descriptor: self.descriptor, writer: self.writer).generateSource()
        } else if let _ = self.parentGenerator, IsOneOfField(descriptor) {
            GeneratorOneOfFields(descriptor: self.descriptor, writer: self.writer).generateSource()
        } else if self.descriptor.label == .labelOptional {
            GeneratorOptionalFields(descriptor: self.descriptor, writer: self.writer).generateSource()
        } else if self.descriptor.label == .labelRepeated {
            GeneratorRepeatedFields(descriptor: self.descriptor, writer: self.writer).generateSource()
        } else {
            GeneratorRequiredFields(descriptor: self.descriptor, writer: self.writer).generateSource()
        }
    }
    func generateExtensions() {
        if let parent = self.parentGenerator?.descriptor, IsMapEntry(parent) {
            GeneratorMapFields(descriptor: self.descriptor, writer: self.writer).generateExtensions()
            return
        }
        if IsOneOfField(self.descriptor) {
            GeneratorOneOfFields(descriptor: self.descriptor, writer: self.writer).generateExtensions()
            return
        }
        
        if let parent = self.parentGenerator?.descriptor, IsMapField(self.descriptor, parentDesc: parent) {
            GeneratorMapFields(descriptor: self.descriptor, writer: self.writer).generateExtensionsMaps()
            return
        }
        
        switch self.descriptor.label {
        case .labelOptional:
            GeneratorOptionalFields(descriptor: self.descriptor, writer: self.writer).generateExtensions()
        case .labelRepeated:
            GeneratorRepeatedFields(descriptor: self.descriptor, writer: self.writer).generateExtensions()
        case .labelRequired:
            GeneratorRequiredFields(descriptor: self.descriptor, writer: self.writer).generateExtensions()
        }
    }
    func generateProtobufExtensions() {
        if let parent = self.parentGenerator?.descriptor, IsMapEntry(parent) {
//            self.writer.write("rmModel.\(self.descriptor.name.camelCase()) = proto.\(self.descriptor.name.camelCase())")
//            return
            
        }
        
        if IsOneOfField(self.descriptor) {
            GeneratorOneOfFields(descriptor: self.descriptor, writer: self.writer).generateProtobufExtensions()
            return
        }
        
        if let parent = self.parentGenerator?.descriptor, IsMapField(self.descriptor, parentDesc: parent) {
            GeneratorMapFields(descriptor: self.descriptor, writer: self.writer).generateProtobufExtensions()
            return
        }
        
        switch self.descriptor.label {
        case .labelOptional:
            GeneratorOptionalFields(descriptor: self.descriptor, writer: self.writer).generateProtobufExtensions()
        case .labelRepeated:
            GeneratorRepeatedFields(descriptor: self.descriptor, writer: self.writer).generateProtobufExtensions()
        case .labelRequired:
            GeneratorRequiredFields(descriptor: self.descriptor, writer: self.writer).generateProtobufExtensions()
        }

    }
}

