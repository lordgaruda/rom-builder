mkdir twrp
cd twrp
git config --global user.email "omrameshpatel@gmail.com" && git config --global user.name "takumi021"

# repo
mkdir -p ~/.bin
PATH="${HOME}/.bin:${PATH}"
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/.bin/repo
chmod a+rx ~/.bin/repo

# python
sudo apt-get install python-is-python3

# sync
repo init --depth=1 -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1
repo sync
git clone https://github.com/takumi021/android_device_realme_r5x-twrp device/realme/r5x

# build
. b*/e* && lunch twrp_r5x-userdebug && make recoveryimage

# upload
cd out/target/product/r5x
curl -sL https://git.io/file-transfer | sh
./transfer wet recovery.img
