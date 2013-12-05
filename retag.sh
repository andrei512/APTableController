#! /bin/bash

# commit all changes
git add . --all
git ci -am "$2"
git push origin
# remove old tag
git tag -d $1
# push changes 
git push origin :refs/tags/$1
# create new one
git tag -a $1 -m "$1"
# push tags
git push --tags origin
