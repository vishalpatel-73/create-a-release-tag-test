#!/bin/sh -l

# Fail on any error
set -e

cd "${GITHUB_WORKSPACE}" || exit

# Get inputs
GITHUB_TOKEN="${INPUT_GITHUB_TOKEN}"
TAG="${INPUT_TAG}"
MESSAGE="${INPUT_MESSAGE}"
TAG_EXISTS_ERROR="${INPUT_TAG_EXISTS_ERROR}"

# Configure Git
git config --global user.name "github-actions[bot]"
git config --global user.email "github-actions[bot]@users.noreply.github.com"

# Check if the tag already exists
TAG_EXISTS=$(git ls-remote --tags origin | grep -c "refs/tags/${TAG}")

if [ "$TAG_EXISTS" -ne 0 ]; then
  if [ "$TAG_EXISTS_ERROR" = "true" ]; then
    echo "Error: Tag ${TAG} already exists."
    exit 1
  else
    echo "Tag ${TAG} already exists. Skipping creation."
    exit 0
  fi
fi

# Create the new tag
git tag -a "$TAG" -m "$MESSAGE"
git push origin "$TAG"
