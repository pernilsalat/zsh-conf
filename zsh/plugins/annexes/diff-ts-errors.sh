#!/bin/bash

git fetch origin
git worktree add --detach /tmp/navops-master origin/master
git worktree add --detach /tmp/navops-current HEAD

(cd /tmp/navops-master/ui && yarn install --immutable && yarn tsc --noEmit --pretty false > /tmp/master.err 2>&1)
(cd /tmp/navops-current/ui && yarn install --immutable && yarn tsc --noEmit --pretty false > /tmp/current.err 2>&1)

delta --paging=never /tmp/master.err /tmp/current.err

git worktree remove /tmp/navops-master
git worktree remove /tmp/navops-current
git worktree prune
