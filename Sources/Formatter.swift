//
//  Formatter.swift
//  protobuf-swift-realm-runtime
//
//  Created by Alexey Khokhlov on 17.10.2017.
//

import Foundation

internal extension String {
    fileprivate func element(_ i:Int) -> String {
        return String(self[index(self.startIndex, offsetBy: i)])
    }
    
    fileprivate func protoCamelCase() -> String {
        var index = 0
        var returned = ""
        self.forEach({
            if index == 0 {
                let char = String($0).uppercased()
                returned += char
            } else if self.element(index).uppercased() == String($0) {
                returned += String($0).uppercased()
            } else {
                let char = String($0)
                returned += char
            }
            index += 1
        })
        return returned
    }
    
    fileprivate func tempProtoCamelCase() -> String {
        var index = 0
        var returned = ""
        self.forEach({
            if index == 0 {
                let char = String($0).uppercased()
                returned += char
            } else {
                let prev = self.element(index-1)
                if prev.lowercased() != prev {
                    returned += String($0).lowercased()
                } else {
                    returned += String($0)
                }
            }
            index += 1
        })
        return returned
    }
    
    func capitalizedCamelCase(separator:String = ".") -> String {
        let components = self.components(separatedBy: CharacterSet.alphanumerics.inverted).filter({ $0 != ""})
        let separator = self.components(separatedBy: ".").count > 1 ? separator : ""
        let returned = components.map({
            return $0.tempProtoCamelCase()
        }).joined(separator: separator)
        guard String(describing:returned.first) != "." else {
            return String(describing:returned.dropFirst())
        }
        return returned
    }
    
    func underscoreCapitalizedCamelCase(separator:String = "") -> String {
        let returned = self.capitalizedCamelCase(separator: separator)
        let first = returned.first!
        let firstStr = String(describing:first).uppercased()
        let newStr = returned.dropFirst()
        return firstStr + newStr
    }
    
    func camelCase() -> String {
        let str = self.capitalizedCamelCase().components(separatedBy: ".").joined()
        guard let first = str.first else {
            return ""
        }
        let newStr = str.dropFirst()
        return String(describing:first).lowercased() + String(describing:newStr)
    }
    
    func normalizedCamelCase() -> String {
        let components = self.components(separatedBy: CharacterSet.alphanumerics.inverted).filter({ $0 != ""})
        let separator = self.components(separatedBy: ".").count > 1 ? "." : ""
        let returned = components.map({
            return $0.tempProtoCamelCase()
        }).joined(separator: separator)
        return returned
    }
}

