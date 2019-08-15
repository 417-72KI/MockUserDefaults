carthage_boot:
	carthage bootstrap --platform iOS --no-use-binaries --cache-builds
xcode:
	mint run xcodegen
	pod install
	open MockUserDefaultsDemo.xcworkspace
