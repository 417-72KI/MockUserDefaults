project_name = MockUserDefaults

test:
	bundle exec fastlane test

lint:
	pod spec lint --no-clean --allow-warnings

deploy:
	pod trunk push $(project_name).podspec --allow-warnings

demo_app:
	$(MAKE) -C DemoApp carthage_boot xcode

test_demo:
	bundle exec fastlane test_demo
