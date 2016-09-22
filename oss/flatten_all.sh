#!/bin/bash

# git credential-corpsso login

container="CONTAINER"

# Expects repo name
function flattenRepo {
  echo
  echo Resetting current branch
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

  repoName="$1"
  echo
  echo Making $repoName/ directory
  mkdir $repoName
  echo

  # BETTER: Git discourages "Porcelain" commands, check out Git "plumbing"
  for branch in $(git branch | tr -d '*'); do
      git checkout $branch
      echo
      echo For branch $branch:
      echo -----------------------------
      echo
      echo Making directory: $repoName/$branch/
      mkdir $repoName/$branch
      for file in `ls` ; do
        # If the "file" is a directory
        if test -d $file; then
          if [ $file == oss ]; then
            echo Skipping oss directory
          elif [ $file == $repoName ]; then
            echo Skipping $repoName directory
          elif [ $file == node_modules ]; then
            echo Skipping node_modules directory
          else
            echo Copying $file/ directory into $repoName/$branch/$file/
            cp -rf $file $repoName/$branch/$file
          fi
        # If the "file" is a file
        else
          echo Copying $file file into $repoName/$branch/$file
          cp $file $repoName/$branch/$file
        fi
      done
      echo -----------------------------
      echo
  done
}

echo
echo Making directory: $container/
mkdir $container
echo
for repo in `ls` ; do
  # If the "repo" is a directory
  if test -d $repo; then
    if [ $repo == oss ]; then
      echo Skipping oss directory
    elif [ $repo == $container ]; then
      echo Skipping $container directory
    else
      # echo Copying $directory/ directory into $container/$directory
      # cp -rf $file $repoName/$branch/$file
      # mkdir $container/$repo
      echo
      echo Dropping into $repo directory
      cd $repo
      echo ============================================
      flattenRepo $repo
      echo Done flattening $repo
      cd ..
      echo
      echo Moving $repo/$repo/ into $container/$repo/
      mv $repo/$repo $container/$repo
      echo
      echo
      echo
    fi
  # If the "directory" is a file
  else
    echo skipping $repo file
  fi
done
echo -----------------------------
echo
