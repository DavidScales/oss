#!/bin/bash

git reset --hard

echo Tracking all remote branches
git branch -r | grep -v '\->' | while read remote; do git branch --track "${remote#origin/}" "$remote"; done

echo Pulling all remote branches
git pull --all

# ./oss/scrub.sh
# ./oss/delete_DS_store.sh
# ./oss/headers.sh
# ./oss/readme.sh
./oss/remove_nodes.sh
