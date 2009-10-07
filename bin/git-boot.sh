#!/bin/bash

# Quick init for git projects

git init
echo "*.pyc" >> .gitignore
echo "*~" >> .gitignore
echo "*.swp" >> .gitignore
echo "?humbs.db" >> .gitignore
git add .gitignore
git commit -m "Initial commit"
