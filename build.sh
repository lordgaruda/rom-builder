#!/usr/bin/env bash

rm -rf /cache/*

BASE_DIR="$(pwd)"
SOURCEDIR="${BASE_DIR}/pixelos"

git config --global user.email "falgunpatel.fv@proton.me" && git config --global user.name "falgunv"
df -h
mkdir -p "${SOURCEDIR}"
cd "${SOURCEDIR}"

# Repo
mkdir -p ~/.bin
PATH="${HOME}/.bin:${PATH}"
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/.bin/repo
chmod a+rx ~/.bin/repo

# Sync Source
repo init -u https://github.com/PixelOS-AOSP/manifest.git -b thirteen --depth=1
repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all)

# Sync Trees
git clone  https://github.com/PixelOS-Devices/device_realme_r5x device/realme/r5x -b thirteen
git clone  https://github.com/PixelOS-Devices/vendor_realme_r5x vendor/realme/r5x -b thirteen
git clone  https://github.com/takumi021/kernel_realme_trinket -b inline kernel/realme/r5x

# Source Patches
#cd frameworks/base
#wget https://raw.githubusercontent.com/sarthakroy2002/random-stuff/main/Patches/Fix-brightness-slider-curve-for-some-devices -a12l.patch
#patch -p1 <*.patch
#cd "${SOURCEDIR}"

# Start Build
source build/envsetup.sh
lunch aosp_r5x-userdebug
make bacon -j$(nproc --all)

# Upload
cd out/target/product/r5x
curl -sL https://git.io/file-transfer | sh
./transfer wet pixelos*.zip
