local M = {}

function M.preset()
  local Kb = require("minv.utils").Keybinding

  return {
    [""] = Kb(),
    ["n"] = Kb({
      -- normal
      ["<C-s>"] = "normal.write",
      ["<Esc>"] = "normal.nohlsearch",
    }),
    ["v"] = Kb(),
    ["x"] = Kb(),
    ["s"] = Kb(),
    ["o"] = Kb(),
    ["!"] = Kb(),
    ["i"] = Kb({
      -- insert
      ["jk"] = "insert.escape",
      ["kj"] = "insert.escape",
    }),
    ["l"] = Kb(),
    ["c"] = Kb(),
    ["t"] = Kb(),
    -- nvim-tree
    tree = Kb({
      ["<C-n>"] = "tree.toggle",
    }),
    -- Bufferline
    bufferline = Kb({
      ["<S-l>"] = "bufferline.goto_next",
      ["<S-h>"] = "bufferline.goto_prev",
      ["<Leader>x"] = "bufferline.close",
    }),
    -- Telescope
    telescope = Kb({
      ["<Leader>f"] = {
        ["f"] = "telescope.grep",
        ["F"] = "telescope.files",
        ["m"] = "telescope.marks",
        ["b"] = "telescope.buffers",
        ["r"] = "telescope.registers",
        ["g"] = "telescope.git_commits",
        ["o"] = "telescope.recent_files",
        ["s"] = "telescope.document_symbols",
        ["S"] = "telescope.workspace_symbols",
      },
    }),
    -- Gitsigns
    gitsigns = Kb({
      ["]g"] = "gitsigns.goto_next_hunk",
      ["[g"] = "gitsigns.goto_prev_hunk",
      ["<Leader>g"] = {
        ["b"] = "gitsigns.blame_line",
        ["r"] = "gitsigns.reset_line",
        ["R"] = "gitsigns.reset_buffer",
        ["s"] = "gitsigns.state_hunk",
        ["S"] = "gitsigns.stage_buffer",
        ["u"] = "gitsigns.undo_stage_hunk",
        ["p"] = "gitsigns.preview_hunk",
      },
    }),
    ---Bindings for toggle comments.
    comment = Kb({
      ["gcc"] = "comment.toggle_line",
      ["gbc"] = "comment.toggle_block",
      ["gc"] = "comment.oplead_line",
      ["gb"] = "comment.oplead_block",
      ["gcO"] = "comment.insert_above",
      ["gco"] = "comment.insert_below",
      ["gcA"] = "comment.insert_eol",
    }),
    ---Bindings for terminals.
    terminal = Kb({
      ["<C-t>"] = "terminal.toggle",
    }),
    ---Bindings on lsp clients attached.
    lsp = Kb({
      ["K"] = "lsp.hover",
      ["g"] = {
        ["k"] = "lsp.show_signature_help",
        ["e"] = "lsp.show_diagnostic",
        ["d"] = "lsp.goto_definition",
        ["D"] = "lsp.goto_declaration",
        ["I"] = "lsp.show_implementation",
        ["r"] = "lsp.show_references",
      },
      ["]e"] = "lsp.goto_next_error",
      ["[e"] = "lsp.goto_prev_error",
      ["]d"] = "lsp.goto_next_diagnostic",
      ["[d"] = "lsp.goto_prev_diagnostic",
      ["<Leader>l"] = {
        ["a"] = "lsp.show_code_action",
        ["e"] = "lsp.show_document_diagnostics",
        ["E"] = "lsp.show workspace_diagnostics",
        ["f"] = "lsp.formatting",
        ["r"] = "lsp.rename",
      },
    }),
    ---Bindings for nvim-cmp.
    cmp = Kb({
      ["<C-d>"] = "cmp.scroll_down",
      ["<C-u>"] = "cmp.scroll_up",
      ["<C-Space>"] = "cmp.complete",
      ["<CR>"] = "cmp.confirm",
      ["<C-e>"] = "cmp.close",
      ["<Tab>"] = "cmp.select_next",
      ["<S-Tab>"] = "cmp.select_prev",
    }),
  }
end

---@param minv MiNV
function M.setup(minv)
  local sources = {
    [""] = {},
    ["n"] = {
      ["normal.write"] = { "<Cmd>write<CR>", "Write buffer" },
      ["normal.nohlsearch"] = { "<Cmd>nohlsearch<CR>", "No hlsearch" },
    },
    ["v"] = {},
    ["x"] = {},
    ["s"] = {},
    ["o"] = {},
    ["!"] = {},
    ["i"] = {
      ["insert.escape"] = { "<Esc>", "Escape" },
    },
    ["l"] = {},
    ["c"] = {},
    ["t"] = {},
  }
  for m, src in pairs(sources) do
    minv.keybindings[m]:apply(src, { mode = m })
  end
end

return M
