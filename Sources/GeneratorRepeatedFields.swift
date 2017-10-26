//
//  GeneratorRepeatedFields.swift
//  protoc-gen-swift_realm
//
//  Created by Alexey Khokhlov on 24.10.2017.
//

import Foundation
import ProtocolBuffers

final class GeneratorRepeatedFields: DescriptorGenerator<Google.Protobuf.FieldDescriptorProto>, CodeGeneratorMethods, FieldsGeneratorMethods {
    
    required init(descriptor: GeneratedDescriptorType, writer: CodeWriter) {
        super.init(descriptor: descriptor, writer: writer)
    }
    func generateSource() {
        if self.typesCasting() == "" {
            return
        }
        self.writer.write("let " + self.descriptor.name.camelCase() + ":" + typesCasting() + " = " + typesCasting() + "()")
    }
    func generateExtensions() {
        func extensionRepeated() -> String {
            switch self.descriptor.type {
            case .typeGroup: fallthrough
            case .typeEnum: fallthrough
            case .typeMessage:
                return "rmModel.\(self.descriptor.name.camelCase()).append(objectsIn:\(self.descriptor.typeName.capitalizedCamelCase(separator: STATIC_SEPARATOR)).map(proto.\(self.descriptor.name.oldCamelCase())))"
            default: return ""
            }
        }
        if extensionRepeated() != "" {
            self.writer.write(extensionRepeated())
        }
    }
    func generateProtobufExtensions() {
        func extensionRepeated() -> String {
            switch self.descriptor.type {
            case .typeGroup: fallthrough
            case .typeEnum: fallthrough
            case .typeMessage:
                return "rmModel.\(self.descriptor.name.camelCase()).append(objectsIn:\(self.descriptor.typeName.capitalizedCamelCase(separator: STATIC_SEPARATOR)).map(proto.\(self.descriptor.name.oldCamelCase())))"
            default: return ""
            }
        }
        if extensionRepeated() != "" {
            self.writer.write("proto.\(self.descriptor.name.camelCase()) += try self.\(self.descriptor.name.oldCamelCase()).map({ value in ")
            self.writer.indent()
            self.writer.write("return try value.protobuf()")
            self.writer.outdent()
            self.writer.write("})")
        }
    }
    
    func typesCasting() -> String {
        switch self.descriptor.type {
        case .typeGroup: fallthrough
        case .typeEnum: fallthrough
        case .typeMessage: return "List<" + self.descriptor.typeName.capitalizedCamelCase(separator: STATIC_SEPARATOR) + ">"
        default: return ""
        }
    }
    
    func dynamicTypes() -> String {
        return ""
    }
    
    func defaultValue() -> String {
        return ""
    }
    
}
