
#!/bin/bash
# to make sure that the shell script fails when any command in the script fails

set -e

read -p "Enter the path of the pod directory : " POD_DIRECTORY_PATH

if [ "$POD_DIRECTORY_PATH" == "" ]
 then 
 POD_DIRECTORY_PATH=$(pwd)
fi 

read -p "Enter the latest version : " NEW_RELEASE_VERSION

if [ "$NEW_RELEASE_VERSION" == "" ]
  then
  exit 1
fi  

# split version into components

IFS='.' read -a ARR_VERSION_COMPONENTS <<< "$NEW_RELEASE_VERSION"
ARRAY_COUNT=${#ARR_VERSION_COMPONENTS[@]}
REVISION_VERSION=${ARR_VERSION_COMPONENTS[ARRAY_COUNT - 1]}

DECREMENTED_REVISION_VERSION=$(($REVISION_VERSION - 1))
NEW_LEGACY_VERSION=${ARR_VERSION_COMPONENTS[0]}.${ARR_VERSION_COMPONENTS[1]}.$DECREMENTED_REVISION_VERSION

# compute variables required for substitution

OLD_RELEASE_REVISION_VERSION=$(($DECREMENTED_REVISION_VERSION - 1))
OLD_LEGACY_REVISION_VERSION=$((OLD_RELEASE_REVISION_VERSION - 1))

OLD_RELEASE_VERSION=${ARR_VERSION_COMPONENTS[0]}.${ARR_VERSION_COMPONENTS[1]}."$OLD_RELEASE_REVISION_VERSION"
OLD_LEGACY_VERSION=${ARR_VERSION_COMPONENTS[0]}.${ARR_VERSION_COMPONENTS[1]}."$OLD_LEGACY_REVISION_VERSION"

echo "old release version : $OLD_RELEASE_VERSION , \nold legacy version :$OLD_LEGACY_VERSION , \nnew release version :$NEW_RELEASE_VERSION , \nnew legacy version :$NEW_LEGACY_VERSION"

# functions

function downloadAndReplaceFramework() {

	cd "$POD_DIRECTORY_PATH"

	echo "\nDownloading file from URL:https://rzp-mobile.s3.amazonaws.com/ios/checkout/"$1"/RazorpayBitcodeX9.framework.zip"

	wget https://rzp-mobile.s3.amazonaws.com/ios/checkout/"$1"/RazorpayBitcodeX9.framework.zip

	unzip RazorpayBitcodeX9.framework.zip

	cp -R Razorpay.framework ./Pod/

	rm -r RazorpayBitcode*.framework.zip Razorpay.framework/ __MACOSX/

}


function pushChangesAndCreatePullRequest() {

	git add .
	git commit -m "updated framework for version $1"
	git push origin r/v"test_$1"

	hub pull-request -F- <<< "iOS Release $1

	updated framework for version $1"

	git tag -a "test_$1" -m "tagging version $1"
	git push origin "test_$1"

}

function updateReadme() {

	sed -i '' "s/$OLD_LEGACY_VERSION/$NEW_LEGACY_VERSION/g" README.md
	sed -i '' "s/$OLD_RELEASE_VERSION/$NEW_RELEASE_VERSION/g" README.md

}

# NEW VERSION POD RELEASE	 

git checkout -b r/v"test_$NEW_RELEASE_VERSION"

# download the latest framework , unzip it place it in the right location and delete the downloaded files

downloadAndReplaceFramework $NEW_RELEASE_VERSION

# update the readme

updateReadme

# update the podspec for the new release

sed -i '' "s/$OLD_RELEASE_VERSION/$NEW_RELEASE_VERSION/g" razorpay-pod.podspec

# push the required changes , create a PR and finally tag it.

pushChangesAndCreatePullRequest $NEW_RELEASE_VERSION

echo "\nRelease of $NEW_RELEASE_VERSION  complete !"

# OLD VERSION POD RELEASE

git checkout master
git pull origin master
git checkout -b r/v"test_$NEW_LEGACY_VERSION"

# download the latest framework , unzip it place it in the right location and delete the downloaded files

downloadAndReplaceFramework $NEW_LEGACY_VERSION

# update the readme

updateReadme

# update the podspec for the new release

sed -i '' "s/$OLD_LEGACY_VERSION/$NEW_LEGACY_VERSION/g" razorpay-pod.podspec

# push the required changes , create a PR and finally tag it.

pushChangesAndCreatePullRequest $NEW_LEGACY_VERSION

echo "\nRelease of $NEW_LEGACY_VERSION  complete !"








