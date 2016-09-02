# BETTER: Git discourages "Porcelain" commands, check out Git "plumbing"
for branch in $(git branch | tr -d '*'); do
    git checkout $branch
    echo Searching for DS_Store
    find . -name ".DS_Store" -delete
    # git add ".DS_Store"
    # BETTER: this is kinda weird:
    git add .
    git reset oss/
    echo Commiting changes to $branch
    git commit -m "Remove: DS_store files"

    # git shortlog
done
