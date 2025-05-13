# Dwm

![Screenshot](screenshot.png "Screenshot")

## Notes

I'm using `pulseaudio` for audio management and `brightnessctl` to change the screen brightness.

[Alacritty](https://alacritty.org) is my terminal. I personally recommend [build it for source](https://github.com/alacritty/alacritty/blob/master/INSTALL.md)

Caskaydia Cover NerdFont is the used font, it can be installed with [this link](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/CascadiaCode.zip).
Then put the content in the `$HOME/.fonts` folder and run `fc-cache`.

## Dependencies

In Ubuntu/Debian:

``` bash
sudo apt install rofi feh brightnessctl
```

## Bar signals

Thanks to [LukeSmithxyz](https://github.com/LukeSmithxyz/dwmblocks) for the signal tip.

In the `kill -${code} $(pidof dwmblocks)` add 34 to the `${code}` in below.

| Application | Code |
| :---------: | :--- |
| pulseaudio | 10 |
| brightnessctl | 11 |
