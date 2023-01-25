#!/usr/bin/env bash

backupPathPrefix=~/backups

userInput=$1
if [[ "${userInput:0:1}" == / || "${userInput:0:2}" == ~[/a-z] ]]
then
    sourceFile=$userInput
else
    sourceFile=$(readlink -f "$1")
fi

targetFile=$backupPathPrefix$sourceFile
targetDirectory=$backupPathPrefix$(dirname "$sourceFile")

lastVersionedFile=$(ls  -at1 "$targetFile".*.bak | head -n 1)

copyCommand="cp \"$lastVersionedFile\" \"$sourceFile\""
read -p "Run $copyCommand [y/N]? " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo Run Manually:
    echo $copyCommand
else
     eval "$copyCommand"
fi
