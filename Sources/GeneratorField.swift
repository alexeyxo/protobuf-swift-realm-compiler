//
//  GeneratorField.swift
//  protobuf-swift-realm-runtimePackageDescription
//
//  Created by Alexey Khokhlov on 18.10.2017.
//

import Foundation
import ProtocolBuffers

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
//            self.writer.write("if self.\(self.descriptor.name.underscoreCapitalizedCamelCase()) {")
//            self.writer.indent()
//            self.writer.write("// Oneof")
//            self.writer.write(RealmExtensionToRealmOptional(self.descriptor, from:"self", to:"self"))
//            self.writer.outdent()
//            self.writer.write("}")
//            return
        }
        
        if let parent = self.parentGenerator?.descriptor, IsMapField(self.descriptor, parentDesc: parent) {
//            self.writer.write("let \(self.descriptor.name.camelCase())List = proto.map ({ key, value in")
//            self.writer.indent()
//            self.writer.write("let obj\(self.descriptor.typeName.underscoreCapitalizedCamelCase()) = \(self.descriptor.typeName.capitalizedCamelCase(separator: STATIC_SEPARATOR))()")
//            self.writer.write("obj\(self.descriptor.typeName.underscoreCapitalizedCamelCase()).key = key")
//            self.writer.write("obj\(self.descriptor.typeName.underscoreCapitalizedCamelCase()).value = value")
//            self.writer.write("return obj\(self.descriptor.typeName.underscoreCapitalizedCamelCase())")
//            self.writer.outdent()
//            self.writer.write("})")
//            self.writer.write("rmModel.\(self.descriptor.name.camelCase()).append(objectsIn:\(self.descriptor.name.camelCase())List)")
//            return
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

//func RealmExtensionToProtoRequired(_ desc:Google.Protobuf.FieldDescriptorProto, from:String, to:String) -> String {
//    switch desc.type {
//    case .typeDouble: fallthrough
//    case .typeFloat:  fallthrough
//    case .typeBool: fallthrough
//    case .typeString: return "\(to).\(desc.name.camelCase()) = \(from).\(desc.name.camelCase())"
//        
//    case .typeGroup: fallthrough
//    case .typeEnum: fallthrough
//    case .typeMessage: return "\(to).\(desc.name.camelCase()) = try \(from).\(desc.name.camelCase()).protobuf()"
//        
//    case .typeBytes: return "\(to).\(desc.name.camelCase()) = \(from).\(desc.name.camelCase())"
//    case .typeInt64: return "\(to).\(desc.name.camelCase()) = Int64(\(from).\(desc.name.camelCase()))!"
//    case .typeUint64: return "\(to).\(desc.name.camelCase()) = UInt64(\(from).\(desc.name.camelCase()))!"
//    case .typeInt32: return "\(to).\(desc.name.camelCase()) = Int32(\(from).\(desc.name.camelCase()))!"
//    case .typeFixed64: return "\(to).\(desc.name.camelCase()) = UInt64(\(from).\(desc.name.camelCase()))!"
//    case .typeFixed32: return "\(to).\(desc.name.camelCase()) = UInt32(\(from).\(desc.name.camelCase()))!"
//    case .typeUint32: return "\(to).\(desc.name.camelCase()) = UInt32(\(from).\(desc.name.camelCase()))!"
//    case .typeSfixed32: return "\(to).\(desc.name.camelCase()) = Int32(\(from).\(desc.name.camelCase()))!"
//    case .typeSfixed64: return "\(to).\(desc.name.camelCase()) = Int64(\(from).\(desc.name.camelCase()))!"
//    case .typeSint32: return "\(to).\(desc.name.camelCase()) = Int32(\(from).\(desc.name.camelCase()))!"
//    case .typeSint64: return "\(to).\(desc.name.camelCase()) = Int64(\(from).\(desc.name.camelCase()))!"
//    }
//}
//
//
//func RealmExtensionRepresentToProtoOptional(_ desc:Google.Protobuf.FieldDescriptorProto) -> String {
//    switch desc.type {
//    case .typeString:
//        return "proto.\(desc.name.camelCase()) = self.\(desc.name.camelCase())"
//    case .typeGroup: fallthrough
//    case .typeEnum: fallthrough
//    case .typeMessage:
//        return "proto.\(desc.name.camelCase()) = try self.\(desc.name.camelCase()).protobuf()"
//    case .typeBytes:
//        return "proto.\(desc.name.camelCase()) = self.\(desc.name.camelCase())"
//    case .typeDouble: fallthrough
//    case .typeFloat:  fallthrough
//    case .typeBool: fallthrough
//    case .typeInt64: fallthrough
//    case .typeUint64: fallthrough
//    case .typeInt32: fallthrough
//    case .typeFixed64: fallthrough
//    case .typeFixed32: fallthrough
//    case .typeUint32: fallthrough
//    case .typeSfixed32: fallthrough
//    case .typeSfixed64: fallthrough
//    case .typeSint32: fallthrough
//    case .typeSint64:
//        return "proto.\(desc.name.camelCase()) = self.\(desc.name.camelCase()).value"
//    }
//}

