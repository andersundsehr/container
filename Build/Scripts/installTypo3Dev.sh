#!/usr/bin/env sh

set -eu

# All development packages must use the same branch. Its metadata declares
# the exact core version required by the split TYPO3 packages.
composer show typo3/cms-backend 14.3.x-dev --all --format=json > /tmp/typo3-dev-metadata.json
core_version=$(php -r '$p=json_decode(file_get_contents("/tmp/typo3-dev-metadata.json"), true, flags: JSON_THROW_ON_ERROR); $v=$p["requires"]["typo3/cms-core"] ?? ""; if (!preg_match("/^14\\.3\\.[0-9]+$/D", $v)) { throw new RuntimeException("Unexpected TYPO3 development core requirement: " . $v); } echo $v;')
composer require \
  "typo3/cms-core:14.3.x-dev as $core_version" \
  "typo3/cms-backend:14.3.x-dev" \
  "typo3/cms-install:14.3.x-dev" \
  "typo3/cms-fluid-styled-content:14.3.x-dev" \
  "typo3/cms-info:14.3.x-dev" \
  "typo3/cms-workspaces:14.3.x-dev" \
  --dev -W --no-progress --no-interaction
