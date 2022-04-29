# MiNV

Super lightweight collections of configs and plugins for
[NeoVim](https://github.com/neovim/neovim), inspired by
[NvChad](https://github.com/NvChad/NvChad) and
[LunarVim](https://github.com/LunarVim/LunarVim).

## Setup

### Pre-requisites

- Neovim 0.7.0+
- Use a [Nerd Font](https://www.nerdfonts.com/) in your terminal emulator
- [ripgrep](https://github.com/BurntSushi/ripgrep) is required for grep
  searching with [Telescope](https://github.com/nvim-telescope/telescope.nvim)

### Try winthin Docker

```sh
docker build -t minv .
docker run -it minv
```

### Install

```sh
# Make a backup if necessary
mv ~/.config/nvim ~/.config/nvim.bak
# Install MiNV
git clone https://github.com/loichyan/minv ~/.config/nvim
# Install plugins
nvim --headless -c "autocmd User PackerComplete quitall" -c PackerSync &> /dev/null
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
cp ~/.config/nvim/examples/example_init.lua ~/.config/nvim/lua/custom.lua
# Install plugins
nvim +PackerSync
```

## License

This project is released under the [GPL-3.0 License](./LICENSE).
