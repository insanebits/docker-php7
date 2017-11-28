#!/bin/bash

version=$1

set -e

image="enigma/php56"

tag="${image}:${version}"

# build main image
echo "Building $tag"
docker build -t "$tag" .

# later others can be added
for type in debug; do
  echo "Building $type"
  cd "$type"
  sed -i "s~^FROM\s.*$~FROM $tag~g" Dockerfile
  docker build -t "${tag}-${type}" .
done