LDFLAGS=-trimpath -ldflags="-s -w"

define build
	CGO_ENABLED=0 GOOS=$1 GOARCH=$2 go build $(LDFLAGS) -o bin/frpc_$1_$2$3 ./cmd/frpc
	CGO_ENABLED=0 GOOS=$1 GOARCH=$2 go build $(LDFLAGS) -o bin/frps_$1_$2$3 ./cmd/frps
endef

all: linux darwin windows

linux:
	$(call build,linux,386)
	$(call build,linux,amd64)

darwin:
	$(call build,darwin,arm64)
	$(call build,darwin,amd64)

windows:
	$(call build,windows,386,.exe)
	$(call build,windows,amd64,.exe)

clean:
	rm -rf bin
