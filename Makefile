.PHONY: all check autogen rebuild build_runner deploy pip_install run_web

run_web:
	flutter run -d web-server --web-hostname 0.0.0.0 --web-port 7777

autogen:
	python3 ./scripts/autogen.py

pip_install:
	pip install -r ./scripts/requirements.txt

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
	flutter pub global run dependency_validator
	flutter pub global run peanut --wasm --extra-args --base-href=/