local M = {}

function M.preset()
  ---@class MiNVPresetPacker
  local preset = {
    setup = {
      prompt_border = "rounded",
    },
  }
  return preset
end

---@param preset MiNVPresetPacker
function M.setup(preset)
  local utils = require("utils")
  local present, packer = pcall(require, "packer")

  -- Install packer.
  if not present then
    local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

    print("Install packer...")
    vim.fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      packer_path,
    })

    -- Load packer.
    vim.cmd("packadd packer.nvim")
    packer = require("packer")
  end

  -- Setup packer.
  packer.init(utils.tbl_merge(preset.setup, {
    display = {
      open_fn = function()
        return require("packer.util").float({ border = preset.setup.prompt_border })
      end,
    },
  }))

  return packer
end

return M
