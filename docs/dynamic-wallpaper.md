# Dynamic Wallpaper

Time-based wallpaper changer for macOS using [dwall](https://github.com/adi1090x/dynamic-wallpaper) by adi1090x.

## How it works

A cron job runs at the top of every hour and selects a wallpaper image based on the current hour (0–23). On macOS, `osascript` via `System Events` sets the image on all desktops.

## Setup

**Repo:** `$HOME/git/dynamic-wallpaper/`
**Installed to:** `/opt/share/dynamic-wallpaper/`
**Binary:** `$HOME/.local/bin/dwall` (symlink)
**Images:** `/opt/share/dynamic-wallpaper/images/<style>/0-23.jpg`
**Cache:** `$HOME/.cache/dwall_current` (path of currently active wallpaper)

### Install

```bash
cd $HOME/git/dynamic-wallpaper
chmod +x install.sh
./install.sh
```

### Cron job

```
0 * * * * $HOME/.local/bin/dwall -s earth
```

Edit with `crontab -e`. The `-s` flag sets the style.

## Changing the style

Available styles: `aurora`, `beach`, `bitday`, `chihuahuan`, `cliffs`, `colony`, `desert`, `earth`, `exodus`, `factory`, `firewatch`, `forest`, `gradient`, `home`, `island`, `lake`, `lakeside`, `market`, `mojave`, `moon`, `mountains`, `room`, `sahara`, `street`, `tokyo`

```bash
crontab -e
# change: $HOME/.local/bin/dwall -s <style>
```

## Adding custom wallpapers

1. Collect 24 images (jpg or png), rename them `0.jpg` through `23.jpg`
2. Create a directory: `/opt/share/dynamic-wallpaper/images/<my-style>/`
3. Copy images into it
4. Run `dwall -s <my-style>`
