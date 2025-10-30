for d in ~/dotfiles/*; do
  [ -d "$d" ] || continue        # skip if not a directory
  src="$(realpath "$d")"
  target="$HOME/.config/$(basename "$d")"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    mv "$target" "${target}_$(date +%Y%m%d%H%M%S).bak"
  fi
  if [ -L "$target" ]; then
    unlink "$target"
  fi
  echo "Linking $src to $target"
  ln -sf "$src" "$target"
done

ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.p10k.zsh ~/.p10k.zsh