#!/bin/bash

headerFile="oss/files/header.txt"
licenseFile="oss/files/LICENSE"
contributingFile="oss/files/CONTRIBUTING.md"

# addHeader openComment closeComment
# e.g. addHeader "/*" "*/"
function addHeader {
  echo -e Adding header to $file
  echo "$1" | cat - $headerFile > temp1
  echo "$2" >> temp1
  cat temp1 $file > temp2
  mv temp2 $file
  rm temp1
}

function addHeadersToFiles {
  # Get all html, css, js files, ignoring node_modules directory
  for file in $(find -E . -type f -not -path "*node_modules*" -not -path "*oss*" -regex '.+\.(html|js|css)$'); do
    if grep -q "Copyright" $file; then
      echo $file already has copyright header
    elif [ ${file: -4} == ".css" ] || [ ${file: -3} == ".js" ]; then
      addHeader "/*" "*/"
      echo Staging $file
      git add $file
    elif [ ${file: -5} == ".html" ]; then
      addHeader "<!--" "-->"
      echo Staging $file
      git add $file
    fi
  done
}

function addLicense {
  if [ -e LICENSE.md ]; then
    echo Converting LICENSE.md to LICENSE
    mv LICENSE.md LICENSE
    echo Staging LICENSE
    git add LICENSE
    git add LICENSE.md
  elif [ -e LICENSE ]; then
    echo A LICENSE file already exists, staging
    git add LICENSE
  else
    echo Adding and staging LICENSE
    cp $licenseFile LICENSE
    git add LICENSE
  fi
}

function addContributing {
  if [ -e CONTRIBUTING.md ]; then
    echo A CONTRIBUTING.md file already exists, staging
    git add CONTRIBUTING.md
  else
    echo Adding and staging CONTRIBUTING.md
    cp $contributingFile CONTRIBUTING.md
    git add CONTRIBUTING.md
  fi
}

# BETTER: Git discourages "Porcelain" commands, check out Git "plumbing"
for branch in $(git branch | tr -d '*'); do
    git checkout $branch
    addHeadersToFiles
    addContributing
    addLicense
    echo Commiting changes to $branch
    git commit -m "Add: OSS headers and files"
done
