# Release Helper

## What is this ?

A doc that helps you release the pod by bypassing the manual overhead.

## Note :-

Always merge the latest version into master , DO NOT MERGE THE LEGACY VERSION as the deployment script is wriiten with that assumption that master will always contain the latest version (latest xcode version and not the Older swift one)

### How to use it ?

Well , its fairly simple there is a script called UpdatePod , run it and enter what it asks you.It will ask you for the path of
the pod directory and the latest version,thats it !!  

It will create two branches , download the required files , update the readme and the podspec and create two PR's.All you have
do is add an assignee get it merged and execute pod trunk push. 

