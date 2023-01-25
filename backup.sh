#!/usr/bin/env bash

backupPathPrefix=~/backups

userInput=$1

if [[ "${userInput:0:1}" == / || "${userInput:0:2}" == ~[/a-z] ]]
then
    sourceFile=$userInput
else
    sourceFile=$(readlink -f "$userInput")
fi

targetFile=$backupPathPrefix$sourceFile
targetDirectory=$backupPathPrefix$(dirname "$sourceFile")

mkdir -p  $targetDirectory

for ((version=0;;version++))
    do
	versionedFile=$targetFile.$version.bak
	if [[ ! -f "$versionedFile" ]]; then
	    echo "Copying $sourceFile to $versionedFile"
	    cp "$sourceFile" "$versionedFile"
	    break
	fi
    done


