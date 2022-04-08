PROJECT_NAME = MockUserDefaults

ver = 2.0.0

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
	| sed '/^#/d' \
	| awk '(/^$$/ || !a[$$0]++){print}' \
	| uniq \
	> .gitignore
	echo 'test_output' >> .gitignore

demo_app:
	xed DemoApp/${PROJECT_NAME}.xcworkspace

test_demo:
	cd DemoApp/${PROJECT_NAME}DemoLib && \
	xcrun xcodebuild \
	-scheme '${PROJECT_NAME}DemoLib' \
	-destination 'platform=macOS' \
	test | xcpretty
