#!/bin/bash

temp="oss/files/temp.md"
headerFile="oss/files/header.txt"

# Grab README from master branch and store in a temp file
# BETTER: Git discourages "Porcelain" commands, check out Git "plumbing"
for branch in $(git branch | tr -d '*'); do
    if [ $branch == "master" ]; then
      git checkout $branch
      if [ -e README.md ]; then
        echo Copying README.md
        cat README.md > $temp
        echo >> $temp
        echo >> $temp
        echo "## License" >> $temp
        echo >> $temp
        cat $headerFile >> $temp
      else
        echo Warning: did not find README in master. Need README in master to copy. Add it.
        exit 1
      fi
    fi
done

# Write README to all other branches
# BETTER: Git discourages "Porcelain" commands, check out Git "plumbing"
for branch in $(git branch | tr -d '*'); do
    git checkout $branch
    if [ -e README.md ]; then
      echo Overwriting and staging README.md on $branch
    else
      echo Adding and staging README.md on $branch
    fi
    cat $temp > README.md
    # Can add disclaimer:
    # echo >> README.md
    # echo This is not an official Google product. >> README.md
    git add README.md
    echo Commiting changes to $branch
    git commit -m "Doc: update/add README"
done
