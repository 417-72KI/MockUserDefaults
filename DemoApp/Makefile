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
	$(MAKE) xcode

xcode:
	mint run xcodegen xcodegen generate --spec App/project.yml
	xed MockUserDefaultsDemo.xcworkspace
