.PHONY: build
build:
	swift build
	swift package generate-xcodeproj

.PHONY: update
update:
	swift package update
	swift package generate-xcodeproj
