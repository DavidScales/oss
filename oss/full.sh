#!/bin/bash
echo
echo Resetting current repo
echo
git reset --hard

echo
echo Tracking all remote branches
git branch -r | grep -v '\->' | while read remote; do git branch --track "${remote#origin/}" "$remote"; done

echo
echo
echo Pulling all remote branches
echo
git pull --all

echo
echo

# ./oss/scrub.sh
# ./oss/delete_DS_store.sh
# ./oss/headers.sh
# ./oss/readme.sh
# ./oss/remove_nodes.sh
# ./oss/branch_to_folder.sh
