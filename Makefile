.PHONY: all check autogen rebuild build_runner deploy pip_install

autogen:
	python ./scripts/autogen.py

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
	/bin/sh scripts/deploy.sh