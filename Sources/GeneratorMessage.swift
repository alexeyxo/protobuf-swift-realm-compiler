//
//  GeneratorMessage.swift
//  protobuf-swift-realm-runtimePackageDescription
//
//  Created by Alexey Khokhlov on 18.10.2017.
//

import Foundation
import ProtocolBuffers

final class GeneratorMessage: ThreeDescriptorGenerator<Google.Protobuf.DescriptorProto, Google.Protobuf.DescriptorProto>, CodeGeneratorMethods {
    var file:GeneratorFile
    init(file:GeneratorFile, descriptor: Google.Protobuf.DescriptorProto, writer: CodeWriter, parentGenerator:GeneratorMessage? = nil) {
        self.file = file
        super.init(descriptor: descriptor, writer: writer)
        self.parentGenerator = parentGenerator
    }
    
    required init(descriptor: GeneratedDescriptorType, writer: CodeWriter) {
        fatalError("init(descriptor:writer:) has not been implemented")
    }
    
    var additionalClassName:String?
    
    func generateSource() {
        if shouldGenerate() {
            self.writer.write("\(AccessControl(self.file.descriptor)) class ", self.className(), ":Object {")
            self.writer.indent()
            if self.additionalClassName == nil {
                self.generateTypeAliases()
            }
            var indexedProperty:[String] = []
            var primaryKey:String? = nil
            self.descriptor.field.sorted(by: { return $0.0.number < $0.1.number }).forEach({
                let fieldGenerator = GeneratorFields(file: self.file, descriptor: $0, writer: self.writer, parentGenerator:self)
                fieldGenerator.generateSource()
                if IsIndexedProperty($0) {
                    indexedProperty.append($0.name.camelCase())
                }
                if IsPrimaryKey($0) {
                    primaryKey = $0.name.camelCase()
                }
            })
            self.generateLinkedObjects()
            self.writer.write()
            GeneratorMessage.generateIndexedProperty(self.writer, property: indexedProperty)
            GeneratorMessage.generatePrimaryKey(self.writer, property: primaryKey)
            
            if IsMapEntry(self.descriptor) {
                self.generateMapPrimaryKey()
                self.generateMapIndexedProperty()
            }
            self.writer.outdent()
            self.writer.write("}")
            if let addClass = AdditionalClassName(self.descriptor), self.additionalClassName == nil {
                let additional = GeneratorMessage(file: self.file, descriptor: self.descriptor, writer: self.writer, parentGenerator: self)
                additional.additionalClassName = addClass
                additional.generateSource()
            }
            
        }
        
        
        if self.additionalClassName == nil {
            //Generate Nested Messages
            self.descriptor.nestedType.forEach({
                GeneratorMessage(file: self.file, descriptor: $0, writer: self.writer, parentGenerator: self).generateSource()
            })
            self.descriptor.enumType.forEach({
                GeneratorEnum(file: self.file, descriptor: $0, writer: self.writer, parentGenerator: self).generateSource()
            })
        }
    }

    func generateTypeAliases() {
        
        self.descriptor.nestedType.forEach({
            let generator = GeneratorMessage(file: self.file, descriptor: $0, writer: self.writer, parentGenerator: self)
            self.writer.write(AccessControl(self.file.descriptor)," typealias ", generator.aliasName(), " = ", generator.className())
        })
        self.descriptor.enumType.forEach({
            let generator = GeneratorEnum(file: self.file, descriptor: $0, writer: self.writer, parentGenerator: self)
            self.writer.write(AccessControl(self.file.descriptor)," typealias ", generator.aliasName(), " = ", generator.className())
        })
        
        if self.descriptor.nestedType.count > 0 || self.descriptor.enumType.count > 0 {
            self.writer.write()
        }
    }
    
    func generateLinkedObjects() {
        if GetLinkedObjects(self.descriptor).count > 0 {
            let objects = GetLinkedObjects(self.descriptor)
            objects.forEach({
                self.writer.write("let \($0.fieldName.camelCase()) = LinkingObjects(fromType: \($0.fromType.capitalizedCamelCase(separator: STATIC_SEPARATOR)).self, property:\"\($0.propertyName.camelCase())\")")
            })
        }
    }
    
    override func shouldGenerate() -> Bool {
        var check = self.file.shouldGenerateFile() || self.checkCurrentDescriptorForGenerateOptions()
        if let parent = self.parentGenerator {
            check = check || parent.shouldGenerate()
        }
        return check
    }
    override func shouldGenerateFile() -> Bool {
        var check = self.checkCurrentDescriptorForGenerateOptions()
        self.descriptor.nestedType.forEach({
            check = check || GeneratorMessage(file: self.file, descriptor: $0, writer: self.writer, parentGenerator:self).shouldGenerateFile()
        })
        self.descriptor.enumType.forEach({
            check = check || GeneratorEnum(file: self.file, descriptor: $0, writer: self.writer, parentGenerator:self).shouldGenerateFile()
        })
        return check
    }
    
    override func checkCurrentDescriptorForGenerateOptions() -> Bool {
        if let option = GetOptions(self.descriptor) {
            if option.hasGenerateRealmObject, option.generateRealmObject {
                return true
            }
        }
        return false
    }
    
    func className() -> String {
        if let add = self.additionalClassName {
            return add.capitalizedCamelCase()
        }
        var fullName = ""
        var parent = self.parentGenerator
        while parent != nil {
            fullName = (parent?.descriptor.name)! + "." + fullName
            parent = parent?.parentGenerator
        }
        fullName += self.descriptor.name + "."
        
        if self.writer.file.hasPackage {
            fullName = self.writer.file.package + "." + fullName
        }
        return fullName.capitalizedCamelCase(separator: STATIC_SEPARATOR)
    }
    
    func protoClassName() -> String {
        var fullName = ""
        var parent = self.parentGenerator
        while parent != nil {
            fullName = (parent?.descriptor.name)! + "." + fullName
            parent = parent?.parentGenerator
        }
        fullName += self.descriptor.name + "."
        if self.writer.file.hasPackage {
            fullName = self.writer.file.package + "." + fullName
        }
        let returned = fullName.oldCapitalizedCamelCase().components(separatedBy: ".")
        if additionalClassName != nil {
            return returned.dropLast().joined(separator: ".")
        }
        return returned.joined(separator: ".")
    }
    
    func aliasName() -> String {
        return self.descriptor.name.capitalizedCamelCase().components(separatedBy: ".").last!
    }
    
    func generateMapPrimaryKey() {
        GeneratorMessage.generatePrimaryKey(self.writer, property: "key")
    }
    
    func generateMapIndexedProperty() {
        GeneratorMessage.generateIndexedProperty(self.writer, property: ["key"])
    }
    
    static func generateIndexedProperty(_ writer:CodeWriter, property:[String]) {
        guard property.count > 0 else {return}
        writer.write("\(AccessControl(writer.file)) override class func indexedProperties() -> [String] {")
        writer.indent()
        writer.write("return [\"\(property.joined(separator: ","))\"]")
        writer.outdent()
        writer.write("}")
    }
    
    static func generatePrimaryKey(_ writer:CodeWriter, property:String?) {
        guard let prop = property else {return}
        writer.write("\(AccessControl(writer.file)) override class func primaryKey() -> String? {")
        writer.indent()
        writer.write("return \"\(prop)\"")
        writer.outdent()
        writer.write("}")
    }
}

extension GeneratorMessage {
    func generateExtensions() {
        if shouldGenerate() {
            self.generateProtoToRealmMethod()
            if let addClass = AdditionalClassName(self.descriptor), self.additionalClassName == nil {
                let additional = GeneratorMessage(file: self.file, descriptor: self.descriptor, writer: self.writer, parentGenerator: self)
                additional.additionalClassName = addClass
                additional.generateExtensions()
            }
        }
        if self.additionalClassName == nil {
            self.descriptor.nestedType.forEach({
                GeneratorMessage(file: self.file, descriptor: $0, writer: self.writer, parentGenerator: self).generateExtensions()
            })
            self.descriptor.enumType.forEach({
                GeneratorEnum(file: self.file, descriptor: $0, writer: self.writer, parentGenerator: self).generateExtensions()
            })
        }
    }
    fileprivate func generateProtoToRealmMethod() {
        self.writer.write("extension \(self.className()):ProtoRealm {")
        self.writer.indent()
        self.writer.write("\(AccessControl(self.file.descriptor)) typealias PBType = \(self.protoClassName())")
        self.writer.write("\(AccessControl(self.file.descriptor)) typealias RMObject = \(self.className())")
        self.writer.write("\(AccessControl(self.file.descriptor)) typealias RepresentationType = Dictionary<String,Any>")
        
        self.writer.write("\(AccessControl(self.file.descriptor)) static func map(_ proto: \(self.protoClassName())) -> \((self.className())) {")
        self.writer.indent()
        self.writer.write("let rmModel = \(self.className())()")
        self.descriptor.field.forEach({
            GeneratorFields(file: self.file, descriptor: $0, writer: self.writer, parentGenerator: self).generateExtensions()
        })
        self.writer.write("return rmModel")
        self.writer.outdent()
        self.writer.write("}")
        self.generateProtobufExtensions()
        self.writer.outdent()
        self.writer.write("}")
        
    }
    func generateProtobufExtensions() {
        self.writer.write("\(AccessControl(self.file.descriptor)) func protobuf() throws -> \(self.protoClassName()) {")
        self.writer.indent()
        self.writer.write("let proto = \(self.protoClassName()).Builder()")
        if IsMapEntry(self.descriptor) {
            self.writer.write("proto.key = self.value")
            self.writer.write("return try proto.build()")
            self.writer.outdent()
            self.writer.write("}")
            return
        }
        self.descriptor.field.forEach({
            GeneratorFields(file: self.file, descriptor: $0, writer: self.writer, parentGenerator: self).generateProtobufExtensions()
        })
        self.writer.write("return try proto.build()")
        self.writer.outdent()
        self.writer.write("}")
    }
}

