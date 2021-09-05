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
	$(MAKE) carthage xcode

carthage:
	mint run Carthage carthage bootstrap --platform iOS --no-use-binaries --cache-builds
xcode: carthage
	mint run xcodegen
	bundle exec pod install
	open MockUserDefaultsDemo.xcworkspace
