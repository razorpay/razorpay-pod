
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
OLD_RELEASE_VERSION=${ARR_VERSION_COMPONENTS[0]}.${ARR_VERSION_COMPONENTS[1]}.$DECREMENTED_REVISION_VERSION

echo "old release version : $OLD_RELEASE_VERSION , \nnew release version :$NEW_RELEASE_VERSION"

# functions

function downloadAndReplaceFramework() {

	cd "$POD_DIRECTORY_PATH"

	echo "\nDownloading file from URL:https://rzp-mobile.s3.amazonaws.com/ios/checkout/"$1"/"$2".framework.zip"

	wget https://rzp-mobile.s3.amazonaws.com/ios/checkout/"$1"/"$2".framework.zip

	unzip "$2".framework.zip

	cp -R Razorpay.framework ./Pod/
  
    # r for recursive i.e for directories , f makes rm consider a success if the file it is trying to delete is not found , as in the 
    # of __MACOSX - a macos dependant file which is generated only when unzipped from iOS 11 zips and not from iOS 8

	rm -rf RazorpayBitcode*.framework.zip Razorpay.framework/ __MACOSX/

}


function pushChangesAndCreatePullRequest() {

	git add .
	git commit -m "updated framework for version $1"
	git push origin r/v"$1"

	hub pull-request -F- <<< "iOS Release $1

	updated framework for version $1"

	git tag -a "$1" -m "tagging version $1"
	git push origin "$1"

}

function updateReadme() {
	sed -i '' "s/$OLD_RELEASE_VERSION/$NEW_RELEASE_VERSION/g" README.md
}

# NEW VERSION POD RELEASE	 

git checkout master
git pull origin master
git checkout -b r/v"$NEW_RELEASE_VERSION"

# download the latest framework , unzip it place it in the right location and delete the downloaded files

downloadAndReplaceFramework $NEW_RELEASE_VERSION "RazorpayBitcodeX9"

# update the readme

updateReadme

# update the podspec for the new release

sed -i '' "s/$OLD_RELEASE_VERSION/$NEW_RELEASE_VERSION/g" razorpay-pod.podspec

# push the required changes , create a PR and finally tag it.

pushChangesAndCreatePullRequest $NEW_RELEASE_VERSION

echo "\nRelease of $NEW_RELEASE_VERSION  complete !"








