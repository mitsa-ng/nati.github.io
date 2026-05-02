#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

printf "\033[0;32mBuilding the site...\033[0m\n"

# Build the project.
hugo --minify

# Go To Public folder
cd public

# If you are deploying to a custom domain
# echo "example.com" > CNAME

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

# Initialize a new git repo in the public folder
git init
git add .

# Create a commit
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

# Get the remote URL of the parent repository
REMOTE_URL=$(git -C .. remote get-url origin)

# Push to the gh-pages branch of the remote repository
# Use --force to overwrite the existing branch
git push --force "$REMOTE_URL" master:gh-pages

# Clean up
cd ..
# We don't remove public/ here because it might be useful for local preview
# but it is already in .gitignore

printf "\033[0;32mDone! Your site will be live soon on the gh-pages branch.\033[0m\n"
printf "\033[0;33mNote: Make sure your GitHub Pages setting is set to the 'gh-pages' branch.\033[0m\n"
