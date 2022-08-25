#!/bin/bash

file="razorpay-pod.podspec"     #the file where you keep your string name


myUser="$(grep 's.version ' $file)"
lastVal=${myUser##* }

sed -i -e "s/$lastVal/1.2.8/g" $file

echo "$lastVal"

# echo "$myUser" | awk '{print $NF}'
