#!/bin/bash

container="container"
echo
echo Making $container directory: $container/
mkdir $container
echo

# BETTER: Git discourages "Porcelain" commands, check out Git "plumbing"
for branch in $(git branch | tr -d '*'); do
    git checkout $branch
    echo
    echo -----------------------------
    echo For branch $branch:
    echo
    echo Making directory: $container/$branch/
    mkdir $container/$branch
    for file in `ls` ; do
      # If the "file" is a directory
      if test -d $file; then
        if [ $file == oss ]; then
          echo Skipping oss directory
        elif [ $file == $container ]; then
          echo Skipping $container directory
        elif [ $file == node_modules ]; then
          echo Skipping node_modules directory
        else
          echo Copying $file/ directory into $container/$branch/$file/
          cp -rf $file $container/$branch/$file
        fi
      # If the "file" is a file
      else
        echo Copying $file file into $container/$branch/$file
        cp $file $container/$branch/$file
      fi
    done
    echo -----------------------------
    echo
done
