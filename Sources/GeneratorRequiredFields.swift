//
//  GeneratorRequiredFields.swift
//  protoc-gen-swift_realm
//
//  Created by Alexey Khokhlov on 24.10.2017.
//

import Foundation
import ProtocolBuffers

final class GeneratorRequiredFields: DescriptorGenerator<Google.Protobuf.FieldDescriptorProto>, CodeGeneratorMethods, FieldsGeneratorMethods {
    
    
    required init(descriptor: GeneratedDescriptorType, writer: CodeWriter) {
        super.init(descriptor: descriptor, writer: writer)
    }
    func generateSource() {
        self.writer.write("\(self.dynamicTypes()) " + self.descriptor.name.camelCase() + ":" + self.typesCasting() + self.defaultValue())
    }
    func generateExtensions() {
        func generateRequiredExtensions() -> String {
            switch self.descriptor.type {
            case .typeDouble: fallthrough
            case .typeFloat:  fallthrough
            case .typeBool: fallthrough
            case .typeString: return "rmModel.\(self.descriptor.name.camelCase()) = proto.\(self.descriptor.name.camelCase())"
                
            case .typeGroup: fallthrough
            case .typeEnum: fallthrough
            case .typeMessage: return "rmModel.\(self.descriptor.name.camelCase()) = \(self.descriptor.typeName.capitalizedCamelCase(separator: STATIC_SEPARATOR)).map(proto.\(self.descriptor.name.camelCase()))"
                
            case .typeBytes: return "rmModel.\(self.descriptor.name.camelCase()) = proto.\(self.descriptor.name.camelCase())"
            case .typeInt64: fallthrough
            case .typeUint64: fallthrough
            case .typeInt32: fallthrough
            case .typeFixed64: fallthrough
            case .typeFixed32: fallthrough
            case .typeUint32: fallthrough
            case .typeSfixed32: fallthrough
            case .typeSfixed64: fallthrough
            case .typeSint32: fallthrough
            case .typeSint64: return "rmModel.\(self.descriptor.name.camelCase()) = Int(proto.\(self.descriptor.name.camelCase()))"
            }
        }
        self.writer.write(generateRequiredExtensions())
    }
    func generateProtobufExtensions() {
        func generateRequiredExtensions() -> String {
            switch self.descriptor.type {
            case .typeDouble: fallthrough
            case .typeFloat:  fallthrough
            case .typeBool: fallthrough
            case .typeString: return "proto.\(self.descriptor.name.camelCase()) = self.\(self.descriptor.name.camelCase())"
                
            case .typeGroup: fallthrough
            case .typeEnum: fallthrough
            case .typeMessage: return "proto.\(self.descriptor.name.camelCase()) = try self.\(self.descriptor.name.camelCase()).protobuf()"
                
            case .typeBytes: return "proto.\(self.descriptor.name.camelCase()) = self.\(self.descriptor.name.camelCase())"
            case .typeInt64: return "proto.\(self.descriptor.name.camelCase()) = Int64(self.\(self.descriptor.name.camelCase()))"
            case .typeUint64: return "proto.\(self.descriptor.name.camelCase()) = UInt64(self.\(self.descriptor.name.camelCase()))"
            case .typeInt32: return "proto.\(self.descriptor.name.camelCase()) = Int32(self.\(self.descriptor.name.camelCase()))"
            case .typeFixed64: return "proto.\(self.descriptor.name.camelCase()) = UInt64(self.\(self.descriptor.name.camelCase()))"
            case .typeFixed32: return "proto.\(self.descriptor.name.camelCase()) = UInt32(self.\(self.descriptor.name.camelCase()))"
            case .typeUint32: return "proto.\(self.descriptor.name.camelCase()) = UInt32(self.\(self.descriptor.name.camelCase()))"
            case .typeSfixed32: return "proto.\(self.descriptor.name.camelCase()) = Int32(self.\(self.descriptor.name.camelCase()))"
            case .typeSfixed64: return "proto.\(self.descriptor.name.camelCase()) = Int64(self.\(self.descriptor.name.camelCase()))"
            case .typeSint32: return "proto.\(self.descriptor.name.camelCase()) = Int32(self.\(self.descriptor.name.camelCase()))"
            case .typeSint64: return "proto.\(self.descriptor.name.camelCase()) = Int64(self.\(self.descriptor.name.camelCase()))"
            }
        }
        self.writer.write(generateRequiredExtensions())
    }
    
    func dynamicTypes() -> String {
        switch self.descriptor.type {
        case .typeDouble: return "dynamic var"
        case .typeFloat:  return "dynamic var"
        case .typeBool: return "dynamic var"
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
        case .typeSint64: return "dynamic var"
        }
    }
    
    
    func typesCasting() -> String {
        switch self.descriptor.type {
        case .typeDouble: return "Double"
        case .typeFloat:  return "Float"
        case .typeBool: return "Bool"
        case .typeString: return "String"
            
        case .typeGroup: fallthrough
        case .typeMessage: fallthrough
        case .typeEnum: return self.descriptor.typeName.capitalizedCamelCase(separator: STATIC_SEPARATOR) + "?"
        case .typeBytes: return "Data"
        case .typeInt64: return "Int"
        case .typeUint64: return "Int"
        case .typeInt32: return "Int"
        case .typeFixed64: return "Int"
        case .typeFixed32: return "Int"
        case .typeUint32: return "Int"
        case .typeSfixed32: return "Int"
        case .typeSfixed64: return "Int"
        case .typeSint32: return "Int"
        case .typeSint64: return "Int"
        }
    }
    
    func defaultValue() -> String {
        switch self.descriptor.type {
        case .typeDouble:
            return " = 0.0"
        case .typeFloat:
            return " = 0.0"
        case .typeBool:
            return " = false"
        case .typeString:
            return " = \"\""
        case .typeGroup: fallthrough
        case .typeEnum: fallthrough
        case .typeMessage:
            return ""
        case .typeBytes:
            return " = Data()"
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
            return " = 0"
        }
    }
}

