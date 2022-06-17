local M = {}

---@param opt table
function M.setup(opt)
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

  packer.startup(opt)
  return packer
end

return M
