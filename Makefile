# ══════════════════════════════════════════════════
#  Ikimina Digital — Project Makefile
#  Run `make help` to see all commands
# ══════════════════════════════════════════════════

.PHONY: help setup get build-runner clean test run build-apk build-aab deploy

help:
	@echo ""
	@echo "  Ikimina Digital — Available Commands"
	@echo "  ─────────────────────────────────────"
	@echo "  make setup        — Full first-time project setup"
	@echo "  make get          — Flutter pub get"
	@echo "  make build-runner — Generate freezed/drift/riverpod code"
	@echo "  make clean        — Clean build artifacts"
	@echo "  make test         — Run all tests"
	@echo "  make run          — Run on connected device (debug)"
	@echo "  make run-release  — Run on connected device (release)"
	@echo "  make build-apk    — Build release APK"
	@echo "  make build-aab    — Build release App Bundle (Play Store)"
	@echo "  make deploy       — Deploy Firestore rules & indexes"
	@echo ""

setup:
	@echo "📦 Installing Flutter dependencies..."
	flutter pub get
	@echo "⚙️  Generating code..."
	dart run build_runner build --delete-conflicting-outputs
	@echo "✅ Setup complete! Next: configure Firebase (see README.md)"

get:
	flutter pub get

build-runner:
	dart run build_runner build --delete-conflicting-outputs

build-runner-watch:
	dart run build_runner watch --delete-conflicting-outputs

clean:
	flutter clean
	flutter pub get

test:
	flutter test test/unit/
	flutter test test/widget/

test-coverage:
	flutter test --coverage
	genhtml coverage/lcov.info -o coverage/html
	open coverage/html/index.html

run:
	flutter run

run-release:
	flutter run --release

build-apk:
	flutter build apk --release --split-per-abi
	@echo "✅ APK built: build/app/outputs/flutter-apk/"

build-aab:
	flutter build appbundle --release
	@echo "✅ App Bundle built: build/app/outputs/bundle/release/"

deploy:
	firebase deploy --only firestore:rules,firestore:indexes,storage

deploy-rules:
	firebase deploy --only firestore:rules

lint:
	flutter analyze

format:
	dart format lib/ test/ --line-length 100

upgrade:
	flutter pub upgrade

outdated:
	flutter pub outdated
