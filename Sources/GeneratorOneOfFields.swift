//
//  GeneratorOneOfFields.swift
//  protoc-gen-swift_realm
//
//  Created by Alexey Khokhlov on 24.10.2017.
//

import Foundation
import ProtocolBuffers


final class GeneratorOneOfFields: DescriptorGenerator<Google.Protobuf.FieldDescriptorProto>, CodeGeneratorMethods, FieldsGeneratorMethods {
    
    required init(descriptor: GeneratedDescriptorType, writer: CodeWriter) {
        super.init(descriptor: descriptor, writer: writer)
    }
    func generateSource() {
        self.writer.write("\(self.dynamicTypes()) " + self.descriptor.name.camelCase() + ":" + self.typesCasting() + self.defaultValue())
    }
    func generateExtensions() {
        func nilPointerGenerate() -> String {
            switch self.descriptor.type {
            case .typeString:
                return "rmModel.\(self.descriptor.name.camelCase()) = nil"
            case .typeGroup: fallthrough
            case .typeEnum: fallthrough
            case .typeMessage:
                return "rmModel.\(self.descriptor.name.camelCase()) = nil"
            case .typeBytes:
                return "rmModel.\(self.descriptor.name.camelCase()) = nil"
            case .typeDouble: fallthrough
            case .typeFloat:  fallthrough
            case .typeBool: fallthrough
            case .typeInt64: fallthrough
            case .typeUint64: fallthrough
            case .typeInt32: fallthrough
            case .typeFixed64: fallthrough
            case .typeFixed32: fallthrough
            case .typeUint32: fallthrough
            case .typeSfixed32: fallthrough
            case .typeSfixed64: fallthrough
            case .typeSint32: fallthrough
            case .typeSint64:
                return "rmModel.\(self.descriptor.name.camelCase()).value = nil"
            }
        }
        func extensionToRealm() -> String {
            switch self.descriptor.type {
            case .typeString:
                return "rmModel.\(self.descriptor.name.camelCase()) = proto.\(self.descriptor.name.camelCase())"
            case .typeGroup: fallthrough
            case .typeEnum: fallthrough
            case .typeMessage:
                return "rmModel.\(self.descriptor.name.camelCase()) = \(self.descriptor.typeName.capitalizedCamelCase(separator: STATIC_SEPARATOR)).map(proto.\(self.descriptor.name.camelCase()))"
            case .typeBytes:
                return "rmModel.\(self.descriptor.name.camelCase()) = proto.\(self.descriptor.name.camelCase())"
            case .typeDouble: fallthrough
            case .typeFloat:  fallthrough
            case .typeBool: fallthrough
            case .typeInt64: fallthrough
            case .typeUint64: fallthrough
            case .typeInt32: fallthrough
            case .typeFixed64: fallthrough
            case .typeFixed32: fallthrough
            case .typeUint32: fallthrough
            case .typeSfixed32: fallthrough
            case .typeSfixed64: fallthrough
            case .typeSint32: fallthrough
            case .typeSint64:
                return "rmModel.\(self.descriptor.name.camelCase()).value = Int(proto.\(self.descriptor.name.camelCase()))"
            }
        }
        
        self.writer.write("if proto.has\(self.descriptor.name.underscoreCapitalizedCamelCase()) {")
        self.writer.indent()
        self.writer.write(extensionToRealm())
        self.writer.outdent()
        self.writer.write("} else {")
        self.writer.indent()
        self.writer.write(nilPointerGenerate())
        self.writer.outdent()
        self.writer.write("}")
        
    }
    
    func generateProtobufExtensions() {
        
    }
    
    func dynamicTypes() -> String {
        switch self.descriptor.type {
        case .typeDouble: return "let"
        case .typeFloat:  return "let"
        case .typeBool: return "let"
        case .typeString: return "dynamic var"
            
        case .typeGroup: fallthrough
        case .typeEnum: fallthrough
        case .typeMessage: return "dynamic var"
            
        case .typeBytes: return "dynamic var"
        case .typeInt64: fallthrough
        case .typeUint64: fallthrough
        case .typeInt32: fallthrough
        case .typeFixed64: fallthrough
        case .typeFixed32: fallthrough
        case .typeUint32: fallthrough
        case .typeSfixed32: fallthrough
        case .typeSfixed64: fallthrough
        case .typeSint32: fallthrough
        case .typeSint64: return "let"
        }
    }
    
    func typesCasting() -> String {
        switch self.descriptor.type {
        case .typeDouble: return "RealmOptional<Double>"
        case .typeFloat:  return "RealmOptional<Float>"
        case .typeBool: return "RealmOptional<Bool>"
        case .typeString: return "String?"
            
        case .typeGroup: fallthrough
        case .typeEnum: fallthrough
        case .typeMessage: return self.descriptor.typeName.capitalizedCamelCase(separator: STATIC_SEPARATOR) + "?"
            
        case .typeBytes: return "Data?"
        case .typeInt64: fallthrough
        case .typeUint64: fallthrough
        case .typeInt32: fallthrough
        case .typeFixed64: fallthrough
        case .typeFixed32: fallthrough
        case .typeUint32: fallthrough
        case .typeSfixed32: fallthrough
        case .typeSfixed64: fallthrough
        case .typeSint32: fallthrough
        case .typeSint64: return "RealmOptional<Int>"
        }
    }
    
    func defaultValue() -> String {
        switch self.descriptor.type {
        case .typeDouble:
            return " = RealmOptional<Double>()"
        case .typeFloat:
            return " = RealmOptional<Float>()"
        case .typeBool:
            return " = RealmOptional<Bool>()"
            
        case .typeString:
            return " = nil"
        case .typeGroup: fallthrough
        case .typeEnum: fallthrough
        case .typeMessage:
            return ""
        case .typeBytes:
            return " = nil"
        case .typeInt64: fallthrough
        case .typeUint64: fallthrough
        case .typeInt32: fallthrough
        case .typeFixed64: fallthrough
        case .typeFixed32: fallthrough
        case .typeUint32: fallthrough
        case .typeSfixed32: fallthrough
        case .typeSfixed64: fallthrough
        case .typeSint32: fallthrough
        case .typeSint64:
            return " = RealmOptional<Int>()"
        }
    }
    
}
