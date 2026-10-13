#!/usr/bin/env bash
# Construye los .deb en out/main (packages/) y out/apps (apps/)
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/.." && pwd)
cd "$ROOT"
export SOURCE_DATE_EPOCH=1700000000   # builds reproducibles
rm -rf out && mkdir -p out/main out/apps
for dir in packages/*/; do
  [ -f "$dir/DEBIAN/control" ] && dpkg-deb --build --root-owner-group "$dir" out/main/
done
for dir in apps/*/; do
  [ -f "$dir/DEBIAN/control" ] && dpkg-deb --build --root-owner-group "$dir" out/apps/
done
ls -l out/*
