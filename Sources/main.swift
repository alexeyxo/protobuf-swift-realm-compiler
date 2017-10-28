import Foundation
import ProtocolBuffers
import ProtobufGeneratorUtils
var data = Stdin.readall()
let request = try! Google.Protobuf.Compiler.CodeGeneratorRequest.parseFrom(data: data!)
let response = Generator(request: request).run()
Stdout.write(bytes: response.data())
exit(0)

