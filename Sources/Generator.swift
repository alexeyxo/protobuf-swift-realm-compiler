//
//  Generator.swift
//  protobuf-swift-realm-runtimePackageDescription
//
//  Created by Alexey Khokhlov on 16.10.2017.
//

import Foundation
import ProtocolBuffers
import ProtobufGeneratorUtils
public protocol CodeGeneratorDescriptor {
    associatedtype GeneratedDescriptorType:GeneratedMessageProtocol
}
public protocol CodeGeneratorLinkDescriptor {
    associatedtype ParentDescriptorType:GeneratedMessageProtocol
}

public protocol CheckDescriptorGenerate {
    func checkCurrentDescriptorForGenerateOptions() -> Bool
    func shouldGenerate() -> Bool
}
public protocol CheckGenerateFile:CheckDescriptorGenerate {
    func shouldGenerateFile() -> Bool
}


public protocol CodeGeneratorMethods {
    func generateSource()
    func generateExtensions()
    func generateProtobufExtensions()
}

public protocol FieldsGeneratorMethods {
    func dynamicTypes() -> String
    func typesCasting() -> String
    func defaultValue() -> String
}

public protocol CodeGenerator:CodeGeneratorDescriptor {
    init(descriptor:GeneratedDescriptorType, writer:CodeWriter)
    var descriptor:GeneratedDescriptorType {get set}
    var writer:CodeWriter {get set}
}

let STATIC_SEPARATOR = "_"

extension CodeGenerator {
    func generateSource() {
    }
}

class DescriptorGenerator<M:GeneratedMessageProtocol>: CodeGenerator {
    typealias GeneratedDescriptorType = M
    var writer: CodeWriter
    var descriptor: GeneratedDescriptorType
    required init(descriptor: GeneratedDescriptorType, writer:CodeWriter) {
        self.descriptor = descriptor
        self.writer = writer
    }
}

class ThreeDescriptorGenerator<C:GeneratedMessageProtocol, L:GeneratedMessageProtocol>: DescriptorGenerator<C>, CodeGeneratorLinkDescriptor, CheckGenerateFile {
    func shouldGenerate() -> Bool {
        return true
    }
    
    func checkCurrentDescriptorForGenerateOptions() -> Bool {
        return true
    }
    func shouldGenerateFile() -> Bool {
        return true
    }
    
    typealias ParentDescriptorType = L
    var parentGenerator:ThreeDescriptorGenerator<ParentDescriptorType,ParentDescriptorType>?
}

final class Generator {
    let request: Google.Protobuf.Compiler.CodeGeneratorRequest
    init(request: Google.Protobuf.Compiler.CodeGeneratorRequest) {
        self.request = request
    }
    func run() -> Google.Protobuf.Compiler.CodeGeneratorResponse {
        let response = Google.Protobuf.Compiler.CodeGeneratorResponse.Builder()
        let generate = self.request.protoFile.filter({
            return self.request.fileToGenerate.contains($0.name)
        })
        let files = generate.map({ desc -> Google.Protobuf.Compiler.CodeGeneratorResponse.File? in
                guard let build = self.shouldGenerateFiles(desc) else {
                    return nil
                }
                return build
        }).flatMap({$0})
        response.setFile(files)
        return try! response.build()
    }
    
    func shouldGenerateFiles(_ fileDescriptor:Google.Protobuf.FileDescriptorProto) -> Google.Protobuf.Compiler.CodeGeneratorResponse.File? {
        let file = Google.Protobuf.Compiler.CodeGeneratorResponse.File.Builder()
        let gen = GeneratorFile(descriptor: fileDescriptor)
        
        guard gen.shouldGenerate() else {
            return nil
        }
        gen.generateSource()
        file.setName(gen.filePath())
        file.setContent(gen.writer.content)
        let build = try? file.build()
        return build
    }
}




