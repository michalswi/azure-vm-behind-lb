#!/usr/bin/env bash

set -e

list=".terraform* terraform* demo*"

for i in $list; do
  echo $i
  rm -rf $i
done 
