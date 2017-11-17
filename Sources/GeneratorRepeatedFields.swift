//
//  GeneratorRepeatedFields.swift
//  protoc-gen-swift_realm
//
//  Created by Alexey Khokhlov on 24.10.2017.
//

import Foundation
import ProtocolBuffers
import ProtobufGeneratorUtils

final class GeneratorRepeatedFields: DescriptorGenerator<Google.Protobuf.FieldDescriptorProto>, CodeGeneratorMethods, FieldsGeneratorMethods {
    
    required init(descriptor: GeneratedDescriptorType, writer: CodeWriter) {
        super.init(descriptor: descriptor, writer: writer)
    }
    func generateSource() {
        self.writer.write("let " + self.descriptor.name.camelCase() + ":" + "List<" + typesCasting() + ">" + " = " +  "List<" + typesCasting() + ">" + "()")
    }
    func generateExtensions() {
        func extensionRepeated() -> String {
            switch self.descriptor.type {
            case .typeGroup: fallthrough
            case .typeEnum: fallthrough
            case .typeMessage:
                return "rmModel.\(self.descriptor.name.camelCase()).append(objectsIn:\(self.descriptor.typeName.capitalizedCamelCase(separator: STATIC_SEPARATOR)).map(proto.\(self.descriptor.name.oldCamelCase())))"
            case .typeDouble: return "rmModel.\(self.descriptor.name.camelCase()).append(objectsIn:proto.\(self.descriptor.name.oldCamelCase()))"
            case .typeFloat:  return "rmModel.\(self.descriptor.name.camelCase()).append(objectsIn:proto.\(self.descriptor.name.oldCamelCase()))"
            case .typeBool: return "rmModel.\(self.descriptor.name.camelCase()).append(objectsIn:proto.\(self.descriptor.name.oldCamelCase()))"
            case .typeString: return "rmModel.\(self.descriptor.name.camelCase()).append(objectsIn:proto.\(self.descriptor.name.oldCamelCase()))"
            case .typeBytes: return "rmModel.\(self.descriptor.name.camelCase()).append(objectsIn:proto.\(self.descriptor.name.oldCamelCase()))"
            case .typeInt64: fallthrough
            case .typeInt32: fallthrough
            case .typeUint64: fallthrough
            case .typeUint32: fallthrough
            case .typeFixed64: fallthrough
            case .typeFixed32: fallthrough
            case .typeSfixed32: fallthrough
            case .typeSfixed64: fallthrough
            case .typeSint32: fallthrough
            case .typeSint64: return "rmModel.\(self.descriptor.name.camelCase()).append(objectsIn:proto.\(self.descriptor.name.oldCamelCase()).map({Int($0)}))"
            }
        }
        self.writer.write(extensionRepeated())
    }
    func generateProtobufExtensions() {
        switch self.descriptor.type {
        case .typeGroup: fallthrough
        case .typeEnum: fallthrough
        case .typeMessage:
            self.writer.write("proto.\(self.descriptor.name.camelCase()) += try self.\(self.descriptor.name.oldCamelCase()).map({ value in")
            self.writer.indent()
            self.writer.write("return try value.protobuf()")
            self.writer.outdent()
            self.writer.write("})")
            return
        case .typeDouble: self.writer.write("proto.\(self.descriptor.name.camelCase()) += self.\(self.descriptor.name.oldCamelCase()).map({$0)})")
        case .typeFloat:  self.writer.write("proto.\(self.descriptor.name.camelCase()) += self.\(self.descriptor.name.oldCamelCase()).map({$0)})")
        case .typeBool: self.writer.write("proto.\(self.descriptor.name.camelCase()) += self.\(self.descriptor.name.oldCamelCase()).map({$0)})")
        case .typeString: self.writer.write("proto.\(self.descriptor.name.camelCase()) += self.\(self.descriptor.name.oldCamelCase()).map({$0})")
        case .typeBytes: self.writer.write("proto.\(self.descriptor.name.camelCase()) += self.\(self.descriptor.name.oldCamelCase()).map({$0}))")
        case .typeInt64: self.writer.write("proto.\(self.descriptor.name.camelCase()) += self.\(self.descriptor.name.oldCamelCase()).map({Int64($0)}))")
        case .typeInt32: self.writer.write("proto.\(self.descriptor.name.camelCase()) += self.\(self.descriptor.name.oldCamelCase()).map({Int32($0)}))")
        case .typeUint64: self.writer.write("proto.\(self.descriptor.name.camelCase()) += self.\(self.descriptor.name.oldCamelCase()).map({UInt64($0)}))")
        case .typeUint32: self.writer.write("proto.\(self.descriptor.name.camelCase()) += self.\(self.descriptor.name.oldCamelCase()).map({UInt32($0)}))")
        case .typeFixed64: self.writer.write("proto.\(self.descriptor.name.camelCase()) += self.\(self.descriptor.name.oldCamelCase()).map({UInt64($0)}))")
        case .typeFixed32: self.writer.write("proto.\(self.descriptor.name.camelCase()) += self.\(self.descriptor.name.oldCamelCase()).map({UInt32($0)}))")
        case .typeSfixed32: self.writer.write("proto.\(self.descriptor.name.camelCase()) += self.\(self.descriptor.name.oldCamelCase()).map({Int32($0)})")
        case .typeSfixed64: self.writer.write("proto.\(self.descriptor.name.camelCase()) += self.\(self.descriptor.name.oldCamelCase()).map({Int64($0)}))")
        case .typeSint32: self.writer.write("proto.\(self.descriptor.name.camelCase()) += self.\(self.descriptor.name.oldCamelCase()).map({Int32($0)}))")
        case .typeSint64: self.writer.write("proto.\(self.descriptor.name.camelCase()) += self.\(self.descriptor.name.oldCamelCase()).map({Int64($0)}))")
        }
    }
    
    func typesCasting() -> String {
        switch self.descriptor.type {
        case .typeGroup: fallthrough
        case .typeEnum: fallthrough
        case .typeMessage: return self.descriptor.typeName.capitalizedCamelCase(separator: STATIC_SEPARATOR)
        case .typeDouble: return "Double"
        case .typeFloat:  return "Float"
        case .typeBool: return "Bool"
        case .typeString: return "String"
        case .typeBytes: return "Data"
        case .typeInt64: return "Int"
        case .typeInt32: return "Int"
        case .typeUint64: return "Int"
        case .typeUint32: return "Int"
        case .typeFixed64: return "Int"
        case .typeFixed32: return "Int"
        case .typeSfixed32: return "Int"
        case .typeSfixed64: return "Int"
        case .typeSint32: return "Int"
        case .typeSint64: return "Int"
        }
    }
    
    func dynamicTypes() -> String {
        return ""
    }
    
    func defaultValue() -> String {
        return ""
    }
    
}
