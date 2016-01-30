# Branching
Branching is pretty hard to understand, so I'll write a short tutorial about how to do it here.  

1. To create a branch in your local repository: `git branch <branchname>`, followed by `git checkout <branchname>` to go into that branch
2. To delete a branch in your local repository: `git branch -d <branchname>`, but make sure you are **NOT** in that branch, or else git will complain.
3. To push your local branch into your remote repo on Github: `git push origin <branchname>`
4. When you cloned a repo, and you get only the branch `master`, but you know the Github repo has another branch, simply do the following to create a local branch to track the remote branch: `git checkout -b <branchname> origin/<branchname>`. This will create a local branch called `<branchname>` to track your remote branch.