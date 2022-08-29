#!/bin/bash

file="razorpay-pod.podspec"     #the file where you keep your string name

NEW_PODSPEC_VERSION=$1

versionLine="$(grep 's.version ' $file | sed 's/"//g' | sed "s/'//g")"
version=${versionLine##* }

echo $version

# echo "$myUser" | awk '{print $NF}'
    