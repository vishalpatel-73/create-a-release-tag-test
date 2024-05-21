# Create Release Tag Action

This action creates a GitHub release tag.

## Inputs

### `github_token`

**Required** The GitHub token for authentication.

### `tag_name`

**Required** The name of the tag to create.

### `commit_sha`

**Required** The commit SHA to tag.

### `force`

Whether to overwrite an existing tag. Default is `false`.

## Outputs

### `tag_name`

The name of the created tag.

## Example usage

```yaml
name: Create Release Tag

on:
  push:
    tags:
      - 'v*.*.*'  # Triggers the workflow for version tags

jobs:
  create_release_tag:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout repository
      uses: actions/checkout@v2

    - name: Create Release Tag
      uses: vishalpatel-73/create-a-release-tag-test@v1
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        tag_name: 'v1.0.0'
        commit_sha: ${{ github.sha }}
        force: true
