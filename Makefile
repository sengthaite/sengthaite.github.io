.PHONY: all check autogen rebuild build_runner deploy pip_install build_web gen_l10n

gen_l10n:
	flutter gen-l10n

build_web:
	flutter build web --base-href=/ --wasm --optimization-level=2

autogen:
	python3 ./scripts/autogen.py

pip_install:
	pip install -r ./scripts/requirements.txt

clean:
	rm -rf ./assets/autogen_meta

build_runner:
	dart run build_runner build --delete-conflicting-outputs

check:
	dependency_validator

add_assets:
	asset_manager add

all: clean autogen build_runner

deploy: clean all
	# flutter pub global run dependency_validator
	flutter pub global run peanut --extra-args --base-href=/ --no-wasm --release
	git push origin --set-upstream gh-pages