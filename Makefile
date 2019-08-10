project_name = MockUserDefaults

test:
	bundle exec fastlane test

lint:
	pod spec lint --no-clean --allow-warnings

deploy:
	pod trunk push $(project_name).podspec --allow-warnings

demo_app:
	cd DemoApp && \
	carthage bootstrap --platform iOS --no-use-binaries --cache-builds && \
	mint run xcodegen && \
	pod install
	open DemoApp/MockUserDefaultsDemo.xcworkspace
