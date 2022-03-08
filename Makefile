PROJECT_NAME = MockUserDefaults

ver = 1.3.0

.SILENT:

bundle:
	bundle install --quiet 2>/dev/null

test: bundle
	bundle exec fastlane test

lint: bundle
	bundle exec pod spec lint --no-clean --allow-warnings

release:
	@scripts/release.sh ${PROJECT_NAME} ${ver}

ignore:
	curl -sS -L https://www.gitignore.io/api/swift,swiftpm,xcode,macos \
	| sed -E 's/^# (Pods\/)/\1/g' \
	| sed -E 's/^# (Carthage\/)/\1/g' \
	| sed -E 's/^(Carthage\/).*/\1/g' \
	| sed -E 's/^# (\.swiftpm)/\1/g' \
	| sed 's/^\*.xcodeproj$$//g' \
	| awk '(/^$$/ || !a[$$0]++){print}' \
	| uniq \
	> .gitignore

init_demo_app:
	$(MAKE) -C DemoApp init

demo_app:
	$(MAKE) -C DemoApp xcode

test_demo: bundle
	bundle exec fastlane test_demo
