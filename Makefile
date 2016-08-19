

install:
    mkdir -p "$(PREFIX)/bin"
    xcodebuild install INSTALL_PATH="$(PREFIX)/bin"