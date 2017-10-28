//
//  GeneratorMapFields.swift
//  protoc-gen-swift_realm
//
//  Created by Alexey Khokhlov on 24.10.2017.
//

import Foundation
import ProtocolBuffers
import ProtobufGeneratorUtils
final class GeneratorMapFields: DescriptorGenerator<Google.Protobuf.FieldDescriptorProto>, CodeGeneratorMethods, FieldsGeneratorMethods {
    required init(descriptor: GeneratedDescriptorType, writer: CodeWriter) {
        super.init(descriptor: descriptor, writer: writer)
    }
    func generateSource() {
        self.writer.write("\(self.dynamicTypes()) " + self.descriptor.name.camelCase() + ":" + self.typesCasting() + self.defaultValue())
    }
    func generateExtensions() {
        self.writer.write("rmModel.\(self.descriptor.name.camelCase()) = proto.\(self.descriptor.name.oldCamelCase())")
    }
    func generateExtensionsMaps() {
        self.writer.write("let \(self.descriptor.name.camelCase())List = proto.\(self.descriptor.name.oldCamelCase()).map ({ key, value -> \(self.descriptor.typeName.capitalizedCamelCase(separator: STATIC_SEPARATOR)) in")
        self.writer.indent()
        self.writer.write("let obj\(self.descriptor.typeName.oldUnderscoreCapitalizedCamelCase()) = \(self.descriptor.typeName.capitalizedCamelCase(separator: STATIC_SEPARATOR))()")
        self.writer.write("obj\(self.descriptor.typeName.oldUnderscoreCapitalizedCamelCase()).key = key")
        self.writer.write("obj\(self.descriptor.typeName.oldUnderscoreCapitalizedCamelCase()).value = value")
        self.writer.write("return obj\(self.descriptor.typeName.oldUnderscoreCapitalizedCamelCase())")
        self.writer.outdent()
        self.writer.write("})")
        self.writer.write("rmModel.\(self.descriptor.name.camelCase()).append(objectsIn:\(self.descriptor.name.camelCase())List)")
    }
    
    func generateProtobufExtensions() {
        self.writer.write("self.\(self.descriptor.name.camelCase()).forEach({ value in")
        self.writer.indent()
        self.writer.write("proto.\(self.descriptor.name.oldCamelCase())[value.key] = value.value")
        self.writer.outdent()
        self.writer.write("})")
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
