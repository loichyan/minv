# MiNV

Super lightweight collections of configs and plugins for
[NeoVim](https://github.com/neovim/neovim), inspired by
[NvChad](https://github.com/NvChad/NvChad) and
[LunarVim](https://github.com/LunarVim/LunarVim).

## Setup

### Install

```sh
# Make a backup if necessary
mv ~/.config/nvim ~/.config/nvim.bak
# Install MiNV
git clone https://github.com/loichyan/minv ~/.config/nvim
# Install plugins
nvim +PackerSync
```

### Uninstall

```sh
# Remove MiNV and plugins
rm -rf ~/.cache/nvim ~/.local/share/nvim ~/.config/nvim
# Restore the backup if any
mv ~/.config/nvim.bak ~/.config/nvim
```

## Custom config

```sh
# Copy example file
cp ~/.config/nvim/examples/example_init.lua ~/.config/nvim/lua/custom/init.lua
# Install plugins
nvim +PackerSync
```

## License

This project is released under the [GPL-3.0 License](./LICENSE).
