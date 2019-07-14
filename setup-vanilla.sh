#!/bin/bash

versionManifestUrl=$(curl -fsSL 'https://launchermeta.mojang.com/mc/game/version_manifest.json' | jq --arg SERVER_VERSION "$SERVER_VERSION" --raw-output '[.versions[]|select(.id == $SERVER_VERSION)][0].url')
result=$?
if [ $result != 0 ]; then
	>&2 echo "ERROR failed to obtain version manifest URL ($result)"
	exit 1
fi
if [ $versionManifestUrl = "null" ]; then
	>&2 echo "ERROR couldn't find a matching manifest entry for $SERVER_VERSION"
	exit 1
fi
serverDownloadUrl=$(curl -fsSL ${versionManifestUrl} | jq --raw-output '.downloads.server.url')
result=$?
if [ $result != 0 ]; then
	>&2 echo "ERROR failed to obtain version manifest from $versionManifestUrl ($result)"
	exit 1
fi
curl -fsSL -o server.jar $serverDownloadUrl
result=$?
if [ $result != 0 ]; then
	>&2 echo "ERROR failed to download server from $serverDownloadUrl ($result)"
	exit 1
fi
exit 0
