#!/bin/sh

mkdir ./tmp_build
mkdir ./tmp_gitroot

flutter build web --release --base-href=/ --output=./tmp_build

git clone --shared --bare git@github.com:sengthaite/sengthaite.github.io.git .
git symbolic-ref HEAD refs/heads/gh-pages

git add --all --verbose
git status --porcelain
git commit -m "Build web"
git push --verbose --progress tmp_gitroot gh-pages
# git push origin --set-upstream gh-pages

# rm -rf ./tmp_build
# rm -rf ./tmp_gitroot
