//
//  GeneratorOptionalFields.swift
//  protoc-gen-swift_realmPackageDescription
//
//  Created by Alexey Khokhlov on 24.10.2017.
//

import Foundation
import ProtocolBuffers
final class GeneratorOptionalFields: DescriptorGenerator<Google.Protobuf.FieldDescriptorProto>, CodeGeneratorMethods, FieldsGeneratorMethods {
    
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
                return "rmModel.\(self.descriptor.name.camelCase()) = proto.\(self.descriptor.name.oldCamelCase())"
            case .typeGroup: fallthrough
            case .typeEnum: fallthrough
            case .typeMessage:
                return "rmModel.\(self.descriptor.name.camelCase()) = \(self.descriptor.typeName.capitalizedCamelCase(separator: STATIC_SEPARATOR)).map(proto.\(self.descriptor.name.oldCamelCase()))"
            case .typeBytes:
                return "rmModel.\(self.descriptor.name.camelCase()) = proto.\(self.descriptor.name.oldCamelCase())"
            case .typeDouble:  return "rmModel.\(self.descriptor.name.camelCase()).value = proto.\(self.descriptor.name.oldCamelCase())"
            case .typeFloat:  return "rmModel.\(self.descriptor.name.camelCase()).value = proto.\(self.descriptor.name.oldCamelCase())"
            case .typeBool:  return "rmModel.\(self.descriptor.name.camelCase()).value = proto.\(self.descriptor.name.oldCamelCase())"
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
                return "rmModel.\(self.descriptor.name.camelCase()).value = Int(proto.\(self.descriptor.name.oldCamelCase()))"
            }
        }
        
        self.writer.write("if proto.has\(self.descriptor.name.oldUnderscoreCapitalizedCamelCase()) {")
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
                return "proto.\(self.descriptor.name.oldCamelCase()) = value\(self.descriptor.name.oldUnderscoreCapitalizedCamelCase())"
            case .typeGroup: fallthrough
            case .typeEnum: fallthrough
            case .typeMessage:
                return "proto.\(self.descriptor.name.oldCamelCase()) = value\(self.descriptor.name.oldUnderscoreCapitalizedCamelCase())"
            case .typeBytes:
                return "proto.\(self.descriptor.name.oldCamelCase()) = value\(self.descriptor.name.oldUnderscoreCapitalizedCamelCase())"
            case .typeDouble:
                return "proto.\(self.descriptor.name.oldCamelCase()) = value\(self.descriptor.name.oldUnderscoreCapitalizedCamelCase())"
            case .typeFloat:
                return "proto.\(self.descriptor.name.oldCamelCase()) = value\(self.descriptor.name.oldUnderscoreCapitalizedCamelCase())"
            case .typeBool:
                return "proto.\(self.descriptor.name.oldCamelCase()) = value\(self.descriptor.name.oldUnderscoreCapitalizedCamelCase())"
            case .typeInt64:
                return "proto.\(self.descriptor.name.oldCamelCase()) = Int64(value\(self.descriptor.name.oldUnderscoreCapitalizedCamelCase()))"
            case .typeUint64:
                return "proto.\(self.descriptor.name.oldCamelCase()) = UInt64(value\(self.descriptor.name.oldUnderscoreCapitalizedCamelCase()))"
            case .typeInt32:
                return "proto.\(self.descriptor.name.oldCamelCase()) = Int32(value\(self.descriptor.name.oldUnderscoreCapitalizedCamelCase()))"
            case .typeFixed64:
                return "proto.\(self.descriptor.name.oldCamelCase()) = UInt64(value\(self.descriptor.name.oldUnderscoreCapitalizedCamelCase()))"
            case .typeFixed32:
                return "proto.\(self.descriptor.name.oldCamelCase()) = UInt32(value\(self.descriptor.name.oldUnderscoreCapitalizedCamelCase()))"
            case .typeUint32:
                return  "proto.\(self.descriptor.name.oldCamelCase()) = UInt32(value\(self.descriptor.name.oldUnderscoreCapitalizedCamelCase()))"
            case .typeSfixed32:
                return "proto.\(self.descriptor.name.oldCamelCase()) = Int32(value\(self.descriptor.name.oldUnderscoreCapitalizedCamelCase()))"
            case .typeSfixed64:
                return "proto.\(self.descriptor.name.oldCamelCase()) = Int64(value\(self.descriptor.name.oldUnderscoreCapitalizedCamelCase()))"
            case .typeSint32:
                return "proto.\(self.descriptor.name.oldCamelCase()) = Int32(value\(self.descriptor.name.oldUnderscoreCapitalizedCamelCase()))"
            case .typeSint64:
                return "proto.\(self.descriptor.name.oldCamelCase()) = Int64(value\(self.descriptor.name.oldUnderscoreCapitalizedCamelCase()))"
            }
        }
    
        if self.typesTry() == "" {
            self.writer.write("if let value\(self.descriptor.name.oldUnderscoreCapitalizedCamelCase()) = self.\(self.descriptor.name.camelCase())\(self.typesCastingCheckValue()) {")
        } else {
            self.writer.write("if let cast\(self.descriptor.name.oldUnderscoreCapitalizedCamelCase()) = \(self.typesTry()) self.\(self.descriptor.name.camelCase())\(self.typesCastingCheckValue()), let value\(self.descriptor.name.oldUnderscoreCapitalizedCamelCase()) = cast\(self.descriptor.name.oldUnderscoreCapitalizedCamelCase()) {")
        }
        self.writer.indent()
        self.writer.write(extensionToRealm())
        self.writer.outdent()
        self.writer.write("}")
    }
    
    func needGenerateCheckType() -> Bool {
        switch self.descriptor.type {
        case .typeString:
            return true
        case .typeGroup: fallthrough
        case .typeEnum: fallthrough
        case .typeMessage:
            return true
        case .typeBytes:
            return false
        case .typeDouble:
             fallthrough
        case .typeFloat:
             fallthrough
        case .typeBool:
             fallthrough
        case .typeInt64:
             fallthrough
        case .typeUint64:
             fallthrough
        case .typeInt32:
             fallthrough
        case .typeFixed64:
             fallthrough
        case .typeFixed32:
             fallthrough
        case .typeUint32:
             fallthrough
        case .typeSfixed32:
             fallthrough
        case .typeSfixed64:
             fallthrough
        case .typeSint32:
             fallthrough
        case .typeSint64:
             return true
        }
    }
    
    func typesCastingCheckValue() -> String {
        switch self.descriptor.type {
        case .typeDouble: return ".value"
        case .typeFloat:  return ".value"
        case .typeBool: return ".value"
        case .typeString: return ""
            
        case .typeGroup: fallthrough
        case .typeEnum: fallthrough
        case .typeMessage: return "?.protobuf()"
            
        case .typeBytes: return ""
        case .typeInt64: fallthrough
        case .typeUint64: fallthrough
        case .typeInt32: fallthrough
        case .typeFixed64: fallthrough
        case .typeFixed32: fallthrough
        case .typeUint32: fallthrough
        case .typeSfixed32: fallthrough
        case .typeSfixed64: fallthrough
        case .typeSint32: fallthrough
        case .typeSint64: return ".value"
        }
    }
    
    func typesTry() -> String {
        switch self.descriptor.type {
        case .typeDouble: return ""
        case .typeFloat:  return ""
        case .typeBool: return ""
        case .typeString: return ""
            
        case .typeGroup: fallthrough
        case .typeEnum: fallthrough
        case .typeMessage: return "try?"
            
        case .typeBytes: return ""
        case .typeInt64: fallthrough
        case .typeUint64: fallthrough
        case .typeInt32: fallthrough
        case .typeFixed64: fallthrough
        case .typeFixed32: fallthrough
        case .typeUint32: fallthrough
        case .typeSfixed32: fallthrough
        case .typeSfixed64: fallthrough
        case .typeSint32: fallthrough
        case .typeSint64: return ""
        }
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
