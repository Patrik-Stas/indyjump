target_dir="$HOME/.indyjump"
mkdir target_dir
cp -r ./scripts $target_dir
echo "export PATH='$PATH:$target_dir'" >> "$HOME/.bashrc"
echo "Installed scripts:"
ls -lah $target_dir

