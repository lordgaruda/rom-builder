cd awaken

# Start Build
source build/envsetup.sh
lunch awaken_r5x-userdebug
make bacon -j$(nproc --all)

# Upload
cd out/target/product/r5x
curl -sL https://git.io/file-transfer | sh
./transfer wet awaken*.zip
