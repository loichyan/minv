local M = {}

function M.preset()
  return {
    ---Hightlight yanked text.
    hl_yank = {
      highgroup = "Search",
      timeout = 200,
    },
    ---Format on save.
    format_on_save = {
      timeout = nil,
    },
    ---Map `q` to close window.
    q_to_close = {
      "vim",
      "help",
      "man",
      "git",
      "qf",
      "lspinfo",
      "TelescopePrompt",
      "null-ls-info",
    },
    ---Remove trailing spaces.
    trim_spaces = true,
    ---Auto resize windows when changed.
    auto_resize = true,
  }
end

---@param minv MiNV
function M.setup(minv)
  local preset = minv.autocmds
  local au = require("utils").autocmd
  local function au_if(enable, ...)
    if enable then
      au(...)
    end
  end

  if preset.hl_yank ~= nil then
    local cmd = string.format(
      [[lua require("vim.highlight").on_yank({higroup = "%s", timeout = %d})]],
      preset.hl_yank.highgroup,
      preset.hl_yank.timeout
    )
    au("TextYankPost", "*", cmd)
  end
  if preset.format_on_save ~= nil then
    local cmd = string.format(
      [[:silent lua vim.lsp.buf.formatting_sync(nil, %s)]],
      preset.format_on_save.timeout
    )
    au("BufWritePre", "*", cmd)
  end
  if preset.q_to_close ~= nil then
    local ft = table.concat(preset.q_to_close, ",")
    au("FileType", ft, "nnoremap <silent> <buffer> q <Cmd>close!<CR>")
  end
  au_if(preset.trim_spaces, "BufWritePre", "*", [[silent s/\s\+$//e]])
  au_if(preset.auto_resize, "VimResized", "*", "wincmd =")
end

return M
