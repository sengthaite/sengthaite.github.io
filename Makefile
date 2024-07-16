.PHONY: all check autogen rebuild build_runner deploy
autogen:
	python3.11 ./scripts/autogen.py

clean:
	rm -rf ./assets/autogen_meta
	rm -rf ./build

build_runner:
	dart run build_runner build --delete-conflicting-outputs

check:
	dependency_validator

add_assets:
	asset_manager add
 
all: clean autogen build_runner

deploy: clean all
	flutter pub global run peanut --web-renderer=canvaskit --extra-args --base-href=/