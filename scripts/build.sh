#!/bin/sh

set -e

export VERSION=v1.0.0
export REPO_PATH=github.com/coreos/bcrypt-tool

export LD_FLAGS="-w -X ${REPO_PATH}.Version=${VERSION}"

mkdir -p dist

for PLATFORM in $( go tool dist list ); do
    eval $( printf "export GOOS=%s; export GOARCH=%s\n" $( echo $PLATFORM | tr '/' ' ' ) )

    case $GOOS in
    "linux")
        ;;
    "darwin")
        ;;
    "windows")
        ;;
    *)
        continue
        ;;
    esac

    case $GOARCH in
    "arm")
        continue
        ;;
    "arm64")
        continue
        ;;
    esac

    echo "[+] Building for $GOOS $GOARCH"

    TEMP_DIR=$( mktemp -d )
    BUILD_DIR=$TEMP_DIR/bcrypt-tool
    
    go build -ldflags "${LD_FLAGS}" -a -o $BUILD_DIR/bcrypt-tool $REPO_PATH

    ARCHIVE=dist/bcrypt-tool-$VERSION-$GOOS-$GOARCH.tar.gz
    tar -czf $ARCHIVE -C $TEMP_DIR .
    echo "[+] Built to archive $ARCHIVE"

    rm -rf $TEMP_DIR
done
