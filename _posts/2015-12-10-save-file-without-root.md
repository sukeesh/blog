---
title: "Save a file in vim without root permission"
categories:
  - blog
tags:
  - unix
  - tricks
  - vim
---

This happens lot of times. You open Vim to edit a system file, do some changes, and `:wq`.
We won't be able to save a file due to permission issues. 

To save a file, simply type the following command.

`:w !sudo tee %` and enter the password as prompted. Voila.

## Add this to your ~/.vimrc file

Edit `~/.vimrc` and append the following code:

`command W :execute ':silent w !sudo tee % > /dev/null' | :edit!`

Save and close the file. Now, try to edit a privileged file. Now, write a privileged file with custom command `:W`