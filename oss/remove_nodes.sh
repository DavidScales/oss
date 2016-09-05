# Write README to all other branches
# BETTER: Git discourages "Porcelain" commands, check out Git "plumbing"
for branch in $(git branch | tr -d '*'); do
    git checkout $branch
    if [ -d node_modules ]; then
      echo Removing node_modules
      rm -rf node_modules
      echo Staging and commiting to $branch
      git add node_modules
      git commit -m "Remove: node_modules"
    fi
done
