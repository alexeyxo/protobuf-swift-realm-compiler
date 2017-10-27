//
//  PluginUtils.swift
//  protobuf-swift-realm-runtimePackageDescription
//
//  Created by Alexey Khokhlov on 18.10.2017.
//

import Foundation
import ProtocolBuffers
func GetOptions(_ desc:Google.Protobuf.DescriptorProto) -> Google.Protobuf.SwiftMessageOptions? {
    if desc.options != nil {
        if desc.options.hasExtension(extensions: Google.Protobuf.SwiftDescriptorRoot.swiftMessageOptions()),
            let option = desc.options.getExtension(extensions: Google.Protobuf.SwiftDescriptorRoot.swiftMessageOptions()) as? Google.Protobuf.SwiftMessageOptions {
            return option
        }
    }
    return nil
}

func GetOptions(_ desc:Google.Protobuf.FileDescriptorProto) -> Google.Protobuf.SwiftFileOptions? {
    if desc.options != nil {
        if desc.options.hasExtension(extensions: Google.Protobuf.SwiftDescriptorRoot.swiftFileOptions()),
            let option = desc.options.getExtension(extensions: Google.Protobuf.SwiftDescriptorRoot.swiftFileOptions()) as? Google.Protobuf.SwiftFileOptions {
            return option
        }
    }
    return nil
}


func GetOptions(_ desc:Google.Protobuf.EnumDescriptorProto) -> Google.Protobuf.SwiftEnumOptions? {
    if desc.options != nil {
        if desc.options.hasExtension(extensions: Google.Protobuf.SwiftDescriptorRoot.swiftEnumOptions()),
            let option = desc.options.getExtension(extensions: Google.Protobuf.SwiftDescriptorRoot.swiftEnumOptions()) as? Google.Protobuf.SwiftEnumOptions {
            return option
        }
    }
    return nil
}

func GetOptions(_ desc:Google.Protobuf.FieldDescriptorProto) -> Google.Protobuf.SwiftFieldOptions? {
    if desc.options != nil {
        if desc.options.hasExtension(extensions: Google.Protobuf.SwiftDescriptorRoot.swiftFieldOptions()),
            let option = desc.options.getExtension(extensions: Google.Protobuf.SwiftDescriptorRoot.swiftFieldOptions()) as? Google.Protobuf.SwiftFieldOptions {
            return option
        }
    }
    return nil
}

func IsPrimaryKey(_ desc:Google.Protobuf.FieldDescriptorProto) -> Bool {
    if desc.options != nil {
        if desc.options.hasExtension(extensions: Google.Protobuf.SwiftDescriptorRoot.swiftFieldOptions()),
            let option = desc.options.getExtension(extensions: Google.Protobuf.SwiftDescriptorRoot.swiftFieldOptions()) as? Google.Protobuf.SwiftFieldOptions {
            return option.realmPrimaryKey || desc.name == "id"
        }
    } else if desc.name == "id" {
        return true
    }
    return false
}

func IsIndexedProperty(_ desc:Google.Protobuf.FieldDescriptorProto) -> Bool {
    if desc.options != nil {
        if desc.options.hasExtension(extensions: Google.Protobuf.SwiftDescriptorRoot.swiftFieldOptions()),
            let option = desc.options.getExtension(extensions: Google.Protobuf.SwiftDescriptorRoot.swiftFieldOptions()) as? Google.Protobuf.SwiftFieldOptions {
            return option.realmIndexedPropertie || IsPrimaryKey(desc)
        }
        
    } else if IsPrimaryKey(desc) {
        return true
    }
    else if desc.name == "id" {
        return true
    }
    return false
}

func IsMapEntry(_ desc:Google.Protobuf.DescriptorProto) -> Bool {
    if desc.options != nil && desc.options.hasMapEntry {
        return desc.options.mapEntry
    }
    return false
}

func IsMapField(_ desc:Google.Protobuf.FieldDescriptorProto, parentDesc:Google.Protobuf.DescriptorProto) -> Bool {
    guard desc.label == .labelRepeated  else {
        return false
    }
    guard desc.typeName != nil else {
        return false
    }
    let comp = desc.typeName.capitalizedCamelCase()
    let name = comp.components(separatedBy:".").last!
    let filtered = parentDesc.nestedType.filter({
        return $0.name.capitalizedCamelCase() == name && IsMapEntry($0)

    })
    return filtered.count == 1
}


func AccessControl(_ desc:Google.Protobuf.FileDescriptorProto) -> String {
    if let options = GetOptions(desc) {
        switch options.entitiesAccessControl {
        case .internalEntities: return "internal"
        case .publicEntities: return "public"
        }
    }
    return "public"
}

func IsOneOfField(_ desc:Google.Protobuf.FieldDescriptorProto) -> Bool {
    return desc.hasOneofIndex
}

func GetLinkedObjects(_ desc:Google.Protobuf.DescriptorProto) -> [Google.Protobuf.LinkedObject] {
    if let options = GetOptions(desc), options.linkedObjects.count > 0 {
        return options.linkedObjects
    }
    return []
}

func AdditionalClassName(_ desc:Google.Protobuf.DescriptorProto) -> String? {
    if let options = GetOptions(desc) {
        if options.hasAdditionalClassName, options.additionalClassName != nil {
            return options.additionalClassName
        }
    }
    return nil
}

func GetOneOfField(_ desc:Google.Protobuf.FieldDescriptorProto, parentDesc:Google.Protobuf.DescriptorProto) -> Google.Protobuf.OneofDescriptorProto? {
    guard desc.hasOneofIndex, let index = desc.oneofIndex else {
        return nil
    }
    return parentDesc.oneofDecl[Int(index)]
}

