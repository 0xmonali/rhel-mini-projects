# OnboardOps — RH124 Ch2 / Ch7 / Ch10 / Ch11

## Problem
Standardize user provisioning and shared-folder access for a project team, avoiding accidental sudo access and broken file permissions.

## Chapter mapping
- Ch10: groupadd, useradd -G, passwd, chage (password aging), sudo via /etc/sudoers.d/<user>
- Ch7: mkdir /shared/project (file management from the command line)
- Ch11: chown, chmod 2775 (SGID), chmod o+t (sticky bit)

## How to run
sudo ./provision.sh
sudo ./verify.sh > verification_output.txt
cat verification_output.txt

## What verify.sh proves
- id: group membership
- chage -l: password aging policy
- sudo -l: only alice has sudo
- ls -ld /shared/project: SGID + sticky bits present
