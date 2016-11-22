#!/bin/sh

set -e

export VERSION=v1.0.0
export REPO_PATH=github.com/coreos/bcrypt-tool

export LD_FLAGS="-w -X ${REPO_PATH}.Version=${VERSION}"

mkdir -p dist

for PLATFORM in $( go tool dist list ); do
    eval $( printf "GOOS=%s; GOARCH=%s\n" $( echo $PLATFORM | tr '/' ' ' ) )

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

    echo "[+] Building for $GOOS $GOARCH"

    TEMP_DIR=$( mktemp -d )
    BUILD_DIR=$TEMP_DIR/bcrypt-tool
    
    mkdir $BUILD_DIR
    UTIME=$( TIMEFORMAT='%lU'; time ( go build -ldflags "${LD_FLAGS}" -a -o $BUILD_DIR/bcrypt-tool $REPO_PATH ) 2>&1 )
    echo "[+] Built in $UTIME"

    ARCHIVE=dist/bcrypt-tool-$VERSION-$GOOS-$GOARCH.tar.gz
    tar -czf $ARCHIVE -C $TEMP_DIR .
    echo "[+] Built to archive $ARCHIVE"

    rm -rf $TEMP_DIR
done
