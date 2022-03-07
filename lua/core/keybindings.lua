local M = {}

function M.preset()
  local utils = require("utils")

  ---@class MiNVKeybindings
  local preset = {
    ---Mappings in n mode.
    n = utils.Keybinding({
      -- normal
      ["<C-s>"] = "normal.write",
      ["<Esc>"] = "normal.nohlsearch",
      -- bufferline
      ["<S-l>"] = "bufferline.goto_next",
      ["<S-h>"] = "bufferline.goto_prev",
      ["<C-c>"] = "bufferline.close",
      -- nvim-tree
      ["<C-b>"] = "tree.toggle",
      ["<C-n>"] = "tree.focus",
      -- git
      ["]g"] = "git.goto_next_hunk",
      ["[g"] = "git.goto_prev_hunk",
      ["<Leader>g"] = {
        ["b"] = "git.blame_line",
        ["r"] = "git.reset_line",
        ["R"] = "git.reset_buffer",
        ["s"] = "git.state_hunk",
        ["S"] = "git.stage_buffer",
        ["u"] = "git.undo_stage_hunk",
        ["p"] = "git.preview_hunk",
      },
      -- telescope
      ["<Leader>f"] = {
        ["f"] = "telescope.grep",
        ["m"] = "telescope.marks",
        ["b"] = "telescope.buffers",
        ["r"] = "telescope.registers",
        ["g"] = "telescope.git_commits",
      },
      -- comment
      ["gcc"] = "comment.toggle_line",
      ["gbc"] = "comment.toggle_block",
      ["gc"] = "comment.operator_line",
      ["gb"] = "comment.operator_block",
      ["gcO"] = "comment.insert_above",
      ["gco"] = "comment.insert_below",
      ["gcA"] = "comment.insert_eol",
      -- terminal
      ["<C-t>"] = "terminal.toggle",
    }),
    ---Mappings in i mode.
    i = utils.Keybinding({
      -- insert
      ["jk"] = "insert.escape",
      ["kj"] = "insert.escape",
    }),
    ---Mappings in x mode.
    x = utils.Keybinding({
      -- comment
      ["gc"] = "comment.operator_line",
      ["gb"] = "comment.operator_block",
    }),
    ---Bindings for terminals.
    terminal = utils.Keybinding({
      ["<C-t>"] = "terminal.toggle",
    }),
    ---Bindings on lsp clients attached.
    lsp = utils.Keybinding({
      ["K"] = "lsp.hover",
      ["g"] = {
        ["k"] = "lsp.show_signature_help",
        ["e"] = "lsp.show_diagnostic",
        ["d"] = "lsp.goto_definition",
        ["D"] = "lsp.goto_declaration",
        ["I"] = "lsp.show_implementation",
        ["r"] = "lsp.show_references",
      },
      ["]e"] = "lsp.goto_next_diagnostic",
      ["[e"] = "lsp.goto_prev_diagnostic",
      ["<Leader>l"] = {
        ["e"] = "lsp.show_document_diagnostics",
        ["E"] = "lsp.show workspace_diagnostics",
        ["f"] = "lsp.formatting",
        ["r"] = "lsp.rename",
      },
    }),
    ---Bindings for nvim-cmp.
    cmp = utils.Keybinding({
      ["<C-d>"] = "cmp.scroll_down",
      ["<C-u>"] = "cmp.scrool_up",
      ["<C-Space>"] = "cmp.complete",
      ["<CR>"] = "cmp.confirm",
      ["<C-e>"] = "cmp.close",
      ["<Tab>"] = "cmp.select_next",
      ["<S-Tab>"] = "cmp.select_prev",
    }),
  }
  return preset
end

---@param minv MiNV
function M.setup(minv)
  minv.keybindings.n:apply(true, {
    -- normal
    ["normal.write"] = { "<Cmd>write<CR>", "Write buffer" },
    ["normal.nohlsearch"] = { "<Cmd>nohlsearch<CR>", "No hlsearch" },
    -- bufferline
    ["bufferline.goto_next"] = { "<Cmd>BufferLineCycleNext<CR>", "Goto next buffer" },
    ["bufferline.goto_prev"] = { "<Cmd>BufferLineCyclePrev<CR>", "Goto prev buffer" },
    ["bufferline.close"] = { "<Cmd>bdelete<CR>", "Close buffer" },
    -- nvim-tree
    ["tree.toggle"] = { "<Cmd>NvimTreeToggle<CR>", "Toggle tree" },
    ["tree.focus"] = { "<Cmd>NvimTreeFocus<CR>", "Focus tree" },
    -- git
    ["git.goto_next_hunk"] = { "<Cmd>Gitsigns next_hunk<CR>", "Goto next hunk" },
    ["git.goto_prev_hunk"] = { "<Cmd>Gitsigns prev_hunk<CR>", "Goto prev hunk" },
    ["git.blame_line"] = { "<Cmd>Gitsigns blame_line<CR>", "Blame line" },
    ["git.reset_line"] = { "<Cmd>Gitsigns reset_hunk<CR>", "Reset hun" },
    ["git.reset_buffer"] = { "<Cmd>Gitsigns reset_buffer<CR>", "Reset buffer" },
    ["git.state_hunk"] = { "<Cmd>Gitsigns stage_hunk<CR>", "Stage hunk" },
    ["git.stage_buffer"] = { "<Cmd>Gitsigns stage_buffer<CR>", "Stage buffer" },
    ["git.undo_stage_hunk"] = { "<Cmd>Gitsigns undo_stage_hunk<CR>", "Undo stage hunk" },
    ["git.preview_hunk"] = { "<Cmd>Gitsigns preview_hunk<CR>", "Preview hunk" },
    -- telescope
    ["telescope.grep"] = { "<Cmd>Telescope live_grep<CR>", "Search strings" },
    ["telescope.marks"] = { "<Cmd>Telescope marks<CR>", "Search marks" },
    ["telescope.buffers"] = { "<Cmd>Telescope buffers<CR>", "Search buffers" },
    ["telescope.registers"] = { "<Cmd>Telescope registers<CR>", "Search registers" },
    ["telescope.git_commits"] = { "<Cmd>Telescope git_commits<CR>", "Search git commits" },
  })
  minv.keybindings.i:apply(true, {
    ["insert.escape"] = { "<Esc>", "Escape" },
  }, { mode = "i" })
  minv.keybindings.x:apply(true, {}, { mode = "x" })
end

return M
