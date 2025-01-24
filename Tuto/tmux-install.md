# Tmux

## Installing

### Dependencies

Need ncurses, libevent and git.

```bash
sudo apt install libevent-dev ncurses-dev build-essential bison pkg-config git
```

You need to install the `tmux-*.tar.gz` file. You can find this file in the [releases](https://github.com/tmux/tmux/releases).

Then for the local installation.

```bash
tar -zxf tmux-*.tar.gz
cd tmux-*/
./configure --prefix=$HOME/.local/bin
make && make install
```

### TPM (Plugin Manager)

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Then put this on the end of `.tmux.conf` file.

```
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

run '~/.tmux/plugins/tpm/tpm'
```
