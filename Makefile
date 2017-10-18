install:
	swift build -c release -Xswiftc -static-stdlib && \
    cp -f ./.build/release/protoc-gen-swift_realm /usr/local/bin/protoc-gen-swift_realm
uninstall:
	rm -f /usr/local/bin/protoc-gen-swift_realm
