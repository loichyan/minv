local M = {}

function M.preset()
  ---@class MiNVAutocmds
  local preset = {
    --- Hightlight yanked text.
    hl_yank = {
      highgroup = "Search",
      timeout = 200,
    },
    --- Format on save.
    format_on_save = {
      timeout = nil,
    },
    --- Map `q` to close window.
    q_to_close = {
      ---@type string[]
      filetype = {
        "vim",
        "help",
        "man",
        "qf",
        "lspinfo",
        "null-ls-info",
      },
    },
    --- Remove trailing spaces.
    trim_spaces = true,
  }
  return preset
end

---@param autocmds MiNVAutocmds
function M.setup(autocmds)
  local au = require("utils").autocmd
  local function au_if(enable, ...)
    if enable then
      au(...)
    end
  end

  if autocmds.hl_yank ~= nil then
    local cmd = string.format(
      [[lua require("vim.highlight").on_yank({higroup = "%s", timeout = %d})]],
      autocmds.hl_yank.highgroup,
      autocmds.hl_yank.timeout
    )
    au("TextYankPost", "*", cmd)
  end
  if autocmds.format_on_save ~= nil then
    local cmd = string.format(
      [[:silent lua vim.lsp.buf.formatting_sync(nil, %s)]],
      autocmds.format_on_save.timeout
    )
    au("BufWritePre", "*", cmd)
  end
  if autocmds.q_to_close ~= nil then
    local ft = table.concat(autocmds.q_to_close.filetype, ",")
    au("FileType", ft, "nnoremap <silent> <buffer> q :close<CR>")
  end
  au_if(autocmds.trim_spaces, "BufWritePre", "*", [[:silent %s/\s\+$//e]])
end

return M
