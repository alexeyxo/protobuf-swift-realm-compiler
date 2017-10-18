import Foundation
import ProtocolBuffers

private let _write = write
private func printToFd(_ s: String, fd: Int32, appendNewLine: Bool = true) {
    let bytes: [UInt8] = [UInt8](s.utf8)
    bytes.withUnsafeBufferPointer { (bp: UnsafeBufferPointer<UInt8>) -> () in
        write(fd, bp.baseAddress, bp.count)
    }
    if appendNewLine {
        [UInt8(10)].withUnsafeBufferPointer { (bp: UnsafeBufferPointer<UInt8>) -> () in
            write(fd, bp.baseAddress, bp.count)
        }
    }
}

class Stdout {
    static func print(_ s: String) { printToFd(s, fd: 1) }
    static func write(bytes: Data) {
        bytes.withUnsafeBytes { (p: UnsafePointer<UInt8>) -> () in
            _ = _write(1, p, bytes.count)
        }
    }
}

class Stdin {
    static func readall() -> Data? {
        let fd: Int32 = 0
        let buffSize = 1024
        var buff = [UInt8]()
        var fragment = [UInt8](repeating: 0, count: buffSize)
        while true {
            let count = read(fd, &fragment, buffSize)
            if count < 0 {
                return nil
            }
            if count < buffSize {
                if count > 0 {
                    buff += fragment[0..<count]
                }
                return Data(bytes: buff)
            }
            buff += fragment
        }
    }
}


func readFileData(filename: String) throws -> Data {
    let url = URL(fileURLWithPath: filename)
    return try Data(contentsOf: url)
}


var data = Stdin.readall()
let request = try! Google.Protobuf.Compiler.CodeGeneratorRequest.parseFrom(data: data!)
let response = Generator(request: request).run()
Stdout.write(bytes: response.data())
exit(0)

