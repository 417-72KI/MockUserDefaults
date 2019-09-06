init:
ifeq (,$(shell which mint))
	echo 'mint not exist'
ifeq (,$(shell which brew))
	echo 'Homebrew not exist'
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
endif
	brew install mint
endif
ifeq (,$(shell which carthage))
	echo 'Carthage not exist'
	brew install carthage
endif
	bundle install
	$(MAKE) carthage_boot xcode

carthage_boot:
	carthage bootstrap --platform iOS --no-use-binaries --cache-builds
xcode:
	mint run xcodegen
	pod install
	open MockUserDefaultsDemo.xcworkspace
