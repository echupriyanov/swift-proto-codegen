#!/bin/sh

# This script regenerates the `src/structs_proto.rs` and `src/keys_proto.rs` files from
# `structs.proto` and `keys.proto`.

sudo docker run --rm -v $(pwd):/usr/code:z -w /usr/code swift /bin/bash -c "
    apt-get update && apt-get install -y wget unzip
    (cd /tmp ; wget https://github.com/protocolbuffers/protobuf/releases/download/v3.8.0/protoc-3.8.0-linux-x86_64.zip)
    (cd /usr/local && unzip /tmp/protoc-3.8.0-linux-x86_64.zip)
    cd /tmp
    git clone https://github.com/apple/swift-protobuf.git
    cd swift-protobuf
    git checkout 1.5.0
    swift build -c release
    cp .build/release/protoc-gen-swift /usr/local/bin
    cd /usr/code
    /usr/local/bin/protoc --swift_out . keys.proto"

sudo chown $USER keys.pb.swift
