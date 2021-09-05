PROJECT_NAME = MockUserDefaults

ver = 1.1.0

.SILENT:
test:
	bundle exec fastlane test

lint:
	bundle exec pod spec lint --no-clean --allow-warnings

release:
	@scripts/release.sh ${PROJECT_NAME} ${ver}

init_demo_app:
	$(MAKE) -C DemoApp init

demo_app:
	$(MAKE) -C DemoApp carthage_boot xcode

test_demo:
	bundle exec fastlane test_demo
