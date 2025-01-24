# Kitty

# Installation

Run the command below to install `kitty` binary

```bash
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
```

Then for desktop integration (need to have `.local/bin` or `PATH`)

```bash
ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/

cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/

sed -i "s|Icon=kitty|Icon=$(readlink -f ~)/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=$(readlink -f ~)/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop

echo 'kitty.desktop' > ~/.config/xdg-terminals.list
```

# Uninstalling

```bash
sudo rm -r ~/.local/kitty.app
rm ~/.local/bin/kitty ~/.local/bin/kitten
rm ~/.local/share/applications/kitty.desktop
rm ~/.local/share/applications/kitty-open.desktop
echo '' > ~/.config/xdg-terminals.list
```
