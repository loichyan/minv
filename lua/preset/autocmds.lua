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
      ["vim"] = true,
      ["help"] = true,
      ["man"] = true,
      ["qf"] = true,
      ["lspinfo"] = true,
      ["TelescopePrompt"] = true,
      ["null-ls-info"] = true,
    },
    --- Remove trailing spaces.
    trim_spaces = true,
  }
  return preset
end

---@param preset MiNVAutocmds
function M.setup(preset)
  local utils = require("utils")
  local au = utils.autocmd
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
    local ft = table.concat(utils.set_to_list(preset.q_to_close), ",")
    au("FileType", ft, "nnoremap <silent> <buffer> q :close!<CR>")
  end
  au_if(preset.trim_spaces, "BufWritePre", "*", [[:silent %s/\s\+$//e]])
end

return M
