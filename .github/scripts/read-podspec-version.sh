#!/bin/bash

file="razorpay-pod.podspec"     #the file where you keep your string name

NEW_PODSPEC_VERSION=$1

versionLine="$(grep 's.version ' $file)"
version=${versionLine##* }

echo version| sed -re 's/(\<.+)\x27(.+\>)/\1 \2/g'

# echo $version

# echo "$myUser" | awk '{print $NF}'
    