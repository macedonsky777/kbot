VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
REGISTRY=777777777777777
APP=$(shell basename $(shell git remote get-url origin))
TARGETOS=linux #macos-darwin windows
TARGETARCH=amd64 #x86-64 

format:
	gofmt -s -w ./

get:
	go get

lint:
	golint

test:
	go test -v

linux: format get
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -v -o kbot -ldflags "-X="github.com/macedonsky777/kbot/cmd.appVersion=${VERSION}

macOS: format get
	CGO_ENABLED=0 GOOS=darwin GOARCH=arm64 go build -v -o kbot -ldflags "-X="github.com/macedonsky777/kbot/cmd.appVersion=${VERSION}

windows: format get
	CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -v -o kbot.exe -ldflags "-X="github.com/macedonsky777/kbot/cmd.appVersion=${VERSION}

build: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/macedonsky777/kbot/cmd.appVersion=${VERSION}

image:
	docker build . --build-arg TARGETOS=${TARGETOS} -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

clean: 
	rm -rf kbot kbot.exe && docker rmi -f ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}
