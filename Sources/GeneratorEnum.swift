//
//  GeneratorEnum.swift
//  protobuf-swift-realm-runtimePackageDescription
//
//  Created by Alexey Khokhlov on 18.10.2017.
//

import Foundation
import ProtocolBuffers

final class GeneratorEnum: ThreeDescriptorGenerator<Google.Protobuf.EnumDescriptorProto, Google.Protobuf.DescriptorProto> {
    var file:GeneratorFile
    init(file:GeneratorFile, descriptor: Google.Protobuf.EnumDescriptorProto, writer: CodeWriter, parentGenerator:GeneratorMessage? = nil) {
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
            self.writer.write("dynamic var rawValue:String = \"\"")
            GeneratorMessage.generatePrimaryKey(self.writer, property: "rawValue")
            GeneratorMessage.generateIndexedProperty(self.writer, property: ["rawValue"])
            self.writer.outdent()
            self.writer.write("}")
        }
    }
    
    func className() -> String {
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
        return fullName.oldCapitalizedCamelCase()
    }
    
    func aliasName() -> String {
        return self.descriptor.name.capitalizedCamelCase(separator: STATIC_SEPARATOR).components(separatedBy: STATIC_SEPARATOR).last!
    }
    
    override func shouldGenerate() -> Bool {
        var check = self.file.shouldGenerateFile() || self.checkCurrentDescriptorForGenerateOptions()
        if let parent = self.parentGenerator {
            check = check || parent.shouldGenerate()
        }
        return check
    }
    
    override func shouldGenerateFile() -> Bool {
        return self.checkCurrentDescriptorForGenerateOptions()
    }
    
    override func checkCurrentDescriptorForGenerateOptions() -> Bool {
        if let option = GetOptions(self.descriptor) {
            if option.hasGenerateRealmObject, option.generateRealmObject {
                return true
            }
        }
        return false
    }
}

extension GeneratorEnum {
    func generateExtensions() {
        if self.shouldGenerate() {
            self.generateProtoToRealmMethod()
            
        }
    }
    fileprivate func generateProtoToRealmMethod() {
        self.writer.write("extension \(self.className()):ProtoRealm {")
        self.writer.indent()
        self.writer.write("\(AccessControl(self.file.descriptor)) typealias PBType = \(self.protoClassName())")
        self.writer.write("\(AccessControl(self.file.descriptor)) typealias RMObject = \(self.className())")
        self.writer.write("\(AccessControl(self.file.descriptor)) typealias RepresentationType = String")
        self.writer.write("\(AccessControl(self.file.descriptor)) static func map(_ proto: \(self.protoClassName())) -> \(self.className()) {")
        self.writer.indent()
        self.writer.write("let rmModel = \(self.className())()")
        self.writer.write("rmModel.rawValue = proto.toString()")
        self.writer.write("return rmModel")
        self.writer.outdent()
        self.writer.write("}")
        self.generateRepresentExtension()
        self.writer.outdent()
        self.writer.write("}")
        
    }
    
    fileprivate func generateRepresentExtension() {
        self.writer.write("\(AccessControl(self.file.descriptor)) func protobuf() throws -> \(self.protoClassName()) {")
        self.writer.indent()
        self.writer.write("return try \(self.protoClassName()).fromString(self.rawValue)")
        self.writer.outdent()
        self.writer.write("}")
    }
}
