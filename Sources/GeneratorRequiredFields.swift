//
//  GeneratorRequiredFields.swift
//  protoc-gen-swift_realm
//
//  Created by Alexey Khokhlov on 24.10.2017.
//

import Foundation
import ProtocolBuffers
import ProtobufGeneratorUtils

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
            case .typeString: return "rmModel.\(self.descriptor.name.camelCase()) = proto.\(self.descriptor.name.oldCamelCase())"
                
            case .typeGroup: fallthrough
            case .typeEnum: fallthrough
            case .typeMessage: return "rmModel.\(self.descriptor.name.camelCase()) = \(self.descriptor.typeName.capitalizedCamelCase(separator: STATIC_SEPARATOR)).map(proto.\(self.descriptor.name.oldCamelCase()))"
                
            case .typeBytes: return "rmModel.\(self.descriptor.name.camelCase()) = proto.\(self.descriptor.name.oldCamelCase())"
            case .typeInt64: fallthrough
            case .typeUint64: fallthrough
            case .typeInt32: fallthrough
            case .typeFixed64: fallthrough
            case .typeFixed32: fallthrough
            case .typeUint32: fallthrough
            case .typeSfixed32: fallthrough
            case .typeSfixed64: fallthrough
            case .typeSint32: fallthrough
            case .typeSint64: return "rmModel.\(self.descriptor.name.camelCase()) = Int(proto.\(self.descriptor.name.oldCamelCase()))"
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
            case .typeString: return "proto.\(self.descriptor.name.oldCamelCase()) = self.\(self.descriptor.name.camelCase())"
                
            case .typeGroup: fallthrough
            case .typeEnum: fallthrough
            case .typeMessage: return "proto.\(self.descriptor.name.oldCamelCase()) = value\(self.descriptor.name.oldUnderscoreCapitalizedCamelCase())"
                
            case .typeBytes: return "proto.\(self.descriptor.name.oldCamelCase()) = self.\(self.descriptor.name.camelCase())"
            case .typeInt64: return "proto.\(self.descriptor.name.oldCamelCase()) = Int64(self.\(self.descriptor.name.camelCase()))"
            case .typeUint64: return "proto.\(self.descriptor.name.oldCamelCase()) = UInt64(self.\(self.descriptor.name.camelCase()))"
            case .typeInt32: return "proto.\(self.descriptor.name.oldCamelCase()) = Int32(self.\(self.descriptor.name.camelCase()))"
            case .typeFixed64: return "proto.\(self.descriptor.name.oldCamelCase()) = UInt64(self.\(self.descriptor.name.camelCase()))"
            case .typeFixed32: return "proto.\(self.descriptor.name.oldCamelCase()) = UInt32(self.\(self.descriptor.name.camelCase()))"
            case .typeUint32: return "proto.\(self.descriptor.name.oldCamelCase()) = UInt32(self.\(self.descriptor.name.camelCase()))"
            case .typeSfixed32: return "proto.\(self.descriptor.name.oldCamelCase()) = Int32(self.\(self.descriptor.name.camelCase()))"
            case .typeSfixed64: return "proto.\(self.descriptor.name.oldCamelCase()) = Int64(self.\(self.descriptor.name.camelCase()))"
            case .typeSint32: return "proto.\(self.descriptor.name.oldCamelCase()) = Int32(self.\(self.descriptor.name.camelCase()))"
            case .typeSint64: return "proto.\(self.descriptor.name.oldCamelCase()) = Int64(self.\(self.descriptor.name.camelCase()))"
            }
        }
        let check = needGenerateCheckType()
        if check {
            self.writer.write("if let cast\(self.descriptor.name.oldUnderscoreCapitalizedCamelCase()) = try? self.\(self.descriptor.name.camelCase())?.protobuf(), let  value\(self.descriptor.name.oldUnderscoreCapitalizedCamelCase()) = cast\(self.descriptor.name.oldUnderscoreCapitalizedCamelCase()) {")
            self.writer.indent()
        }
        self.writer.write(generateRequiredExtensions())
        if check {
            self.writer.outdent()
            self.writer.write("}")
        }
    }
    
    func needGenerateCheckType() -> Bool {
        switch self.descriptor.type {
        case .typeGroup: fallthrough
        case .typeEnum: fallthrough
        case .typeMessage:
            return true
        default: return false
        }
    }
    
    func dynamicTypes() -> String {
        switch self.descriptor.type {
        case .typeDouble: return "@objc dynamic var"
        case .typeFloat:  return "@objc dynamic var"
        case .typeBool: return "@objc dynamic var"
        case .typeString: return "@objc dynamic var"
            
        case .typeGroup: fallthrough
        case .typeEnum: fallthrough
        case .typeMessage: return "@objc dynamic var"
            
        case .typeBytes: return "@objc dynamic var"
        case .typeInt64: fallthrough
        case .typeUint64: fallthrough
        case .typeInt32: fallthrough
        case .typeFixed64: fallthrough
        case .typeFixed32: fallthrough
        case .typeUint32: fallthrough
        case .typeSfixed32: fallthrough
        case .typeSfixed64: fallthrough
        case .typeSint32: fallthrough
        case .typeSint64: return "@objc dynamic var"
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

