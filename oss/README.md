#### Set up
Copy this entire directory into your project's root (the root is where existing files will be searched for and new ones generated). Make sure to delete this directory when you are done with it so it doesn't accidentally get added to your project.

Make sure your repo is up to date so that there are no conflicts

`$ git pull --all`

#### Scrub sensitive information
Run

`$ ./oss/scrub.sh`

This script will check all files on all branches for Google emails/addresses/etc and IP addresses. They will be logged to the screen so you can remove them. They will still be in the git history though...(?)

#### Add Headers, License, and Contributing
Run

`$ ./oss/headers.sh`

This script will check out each branch in your repo and do the following:
* Add a LICENSE.md file
* Add a CONTRIBUTING.md file
* For each file in the branch:
  * Prepend a licensing header using a file-type appropriate comment (for HTML, CSS, and JS files)
* Stage these changes and commit them

You can run the script as many times as you need (e.g. it won't prepend headers to files that already have them).

If you need to undo everything for some reason, before you push, use

```
$ git reset HEAD~
$ git reset --hard
```

This will undo file changes (the added headers) and unstage the license and contributing files (then you can just delete them from the working directory).

#### Copying README's with disclaimer
Place the README that you want in your master branch. Then run

`$ ./oss/readme.sh`

This script will:
* Copy the README.md file in your master branch
* Overwrite the README's in all branches with the copy (if a README doesn't exist in a branch, it will be created)

#### That's it
Then you can push these changes

`$ git push --all`

Feel free to add suggestions. The script is not at all elegant but it was my first time with bash and we are on a schedule ;)
dscales@google.com
