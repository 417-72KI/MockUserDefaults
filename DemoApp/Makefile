.SILENT:

init:
ifeq (,$(shell which mint))
	echo 'mint not exist'
ifeq (,$(shell which brew))
	echo 'Homebrew not exist'
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
endif
	brew install mint
endif
	bundle install
	$(MAKE) xcode

bundle:
	bundle install 2>/dev/null

carthage:
	mint run Carthage carthage bootstrap --platform iOS --use-xcframeworks --no-use-binaries --cache-builds

carthage_update:
	mint run Carthage carthage update --platform iOS --use-xcframeworks --no-use-binaries --cache-builds

xcode: bundle carthage
	mint run xcodegen
	bundle exec pod install
	open MockUserDefaultsDemo.xcworkspace
