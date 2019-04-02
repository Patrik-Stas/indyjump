target_dir="$HOME/.indyjump"
rm -r "$target_dir" || :
mkdir -p "$target_dir"
cp -r "./scripts/"* "$target_dir"
echo "export PATH='$PATH:$target_dir'" >> "$HOME/.bashrc"
echo "Installed scripts:"
ls -lah "$target_dir"

