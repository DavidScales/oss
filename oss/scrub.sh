#!/bin/bash

# BETTER: Git discourages "Porcelain" commands, check out Git "plumbing"
for branch in $(git branch | tr -d '*'); do
    git checkout $branch
    echo ' '
    echo In branch $branch
    for file in $(find -E . -type f -not -path "*node_modules*" -not -path "*oss*" -not -path "*git*"); do
      # BETTER: Don't hardcode "Copyright...", instead, dynamically read from header.txt
      echo $file:
      echo ' '
      egrep '\.google\.com|@google\.com|google[23]?/|([0-9]+\.){3}[0-9]+' $file
      echo ' '
      echo ----
    done
done
