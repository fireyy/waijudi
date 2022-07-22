NAME = $(shell yq e '.name' pubspec.yaml)
VERSION = $(shell yq e '.version' pubspec.yaml)
BUILD_NUMBER = $(shell git rev-list --count main)
APP_PATH := $(CURDIR)

.PHONY: build ipa
ipa:
	flutter build ipa --release --export-options-plist=export_options.plist --build-number=$(BUILD_NUMBER)
build: ipa
clean:
	flutter clean