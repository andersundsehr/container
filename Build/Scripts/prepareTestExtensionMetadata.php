<?php

// TYPO3 14.3 requires Composer metadata even for classic-mode test fixtures.
// Keep the actual installed fixture release; only supply its missing metadata.
require __DIR__ . '/../../.Build/vendor/autoload.php';

$path = Composer\InstalledVersions::getInstallPath('b13/container-example');
if ($path === null) {
    throw new RuntimeException('The container example fixture is not installed');
}
$manifestFile = $path . '/composer.json';
$manifest = json_decode(file_get_contents($manifestFile), true, flags: JSON_THROW_ON_ERROR);
$manifest['extra']['typo3/cms']['version'] = Composer\InstalledVersions::getPrettyVersion('b13/container-example');
$manifest['extra']['typo3/cms']['Package']['providesPackages'] ??= [];
file_put_contents($manifestFile, json_encode($manifest, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES | JSON_THROW_ON_ERROR) . PHP_EOL);
