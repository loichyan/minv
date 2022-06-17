local M = {}

function M.preset()
  local utils = require("minv.utils")

  return {
    [""] = utils.Keybinding(),
    ["n"] = utils.Keybinding({
      -- normal
      ["<C-s>"] = "normal.write",
      ["<Esc>"] = "normal.nohlsearch",
      -- bufferline
      ["<S-l>"] = "bufferline.goto_next",
      ["<S-h>"] = "bufferline.goto_prev",
      ["<Leader>x"] = "bufferline.close",
      -- nvim-tree
      ["<C-n>"] = "tree.toggle",
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
        ["F"] = "telescope.files",
        ["m"] = "telescope.marks",
        ["b"] = "telescope.buffers",
        ["r"] = "telescope.registers",
        ["g"] = "telescope.git_commits",
        ["o"] = "telescope.recent_files",
        ["s"] = "telescope.document_symbols",
        ["S"] = "telescope.workspace_symbols",
      },
      -- comment
      ["gcc"] = "comment.toggle_line",
      ["gbc"] = "comment.toggle_block",
      ["gc"] = "comment.oplead_line",
      ["gb"] = "comment.oplead_block",
      ["gcO"] = "comment.insert_above",
      ["gco"] = "comment.insert_below",
      ["gcA"] = "comment.insert_eol",
      -- terminal
      ["<C-t>"] = "terminal.toggle",
    }),
    ["v"] = utils.Keybinding(),
    ["x"] = utils.Keybinding({
      -- comment
      ["gc"] = "comment.oplead_line",
      ["gb"] = "comment.oplead_block",
    }),
    ["s"] = utils.Keybinding(),
    ["o"] = utils.Keybinding(),
    ["!"] = utils.Keybinding(),
    ["i"] = utils.Keybinding({
      -- insert
      ["jk"] = "insert.escape",
      ["kj"] = "insert.escape",
    }),
    ["l"] = utils.Keybinding(),
    ["c"] = utils.Keybinding(),
    ["t"] = utils.Keybinding(),
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
    cmp = utils.Keybinding({
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
  -- TODO: apply when plugin setup
  local sources = {
    [""] = {},
    ["n"] = {
      -- normal
      ["normal.write"] = { "<Cmd>write<CR>", "Write buffer" },
      ["normal.nohlsearch"] = { "<Cmd>nohlsearch<CR>", "No hlsearch" },
      -- bufferline
      ["bufferline.goto_next"] = {
        "<Cmd>BufferLineCycleNext<CR>",
        "Goto next buffer",
      },
      ["bufferline.goto_prev"] = {
        "<Cmd>BufferLineCyclePrev<CR>",
        "Goto prev buffer",
      },
      ["bufferline.close"] = { "<Cmd>bdelete<CR>", "Close buffer" },
      -- nvim-tree
      ["tree.toggle"] = { "<Cmd>NvimTreeToggle<CR>", "Toggle tree" },
      ["tree.focus"] = { "<Cmd>NvimTreeFocus<CR>", "Focus tree" },
      -- git
      ["git.goto_next_hunk"] = {
        "<Cmd>Gitsigns next_hunk<CR>",
        "Goto next hunk",
      },
      ["git.goto_prev_hunk"] = {
        "<Cmd>Gitsigns prev_hunk<CR>",
        "Goto prev hunk",
      },
      ["git.blame_line"] = { "<Cmd>Gitsigns blame_line<CR>", "Blame line" },
      ["git.reset_line"] = { "<Cmd>Gitsigns reset_hunk<CR>", "Reset hunk" },
      ["git.reset_buffer"] = {
        "<Cmd>Gitsigns reset_buffer<CR>",
        "Reset buffer",
      },
      ["git.state_hunk"] = { "<Cmd>Gitsigns stage_hunk<CR>", "Stage hunk" },
      ["git.stage_buffer"] = {
        "<Cmd>Gitsigns stage_buffer<CR>",
        "Stage buffer",
      },
      ["git.undo_stage_hunk"] = {
        "<Cmd>Gitsigns undo_stage_hunk<CR>",
        "Undo stage hunk",
      },
      ["git.preview_hunk"] = {
        "<Cmd>Gitsigns preview_hunk<CR>",
        "Preview hunk",
      },
      -- telescope
      ["telescope.files"] = {
        "<Cmd>Telescope find_files<CR>",
        "Search files",
      },
      ["telescope.grep"] = {
        "<Cmd>Telescope live_grep<CR>",
        "Search strings",
      },
      ["telescope.marks"] = { "<Cmd>Telescope marks<CR>", "Search marks" },
      ["telescope.buffers"] = {
        "<Cmd>Telescope buffers<CR>",
        "Search buffers",
      },
      ["telescope.registers"] = {
        "<Cmd>Telescope registers<CR>",
        "Search registers",
      },
      ["telescope.git_commits"] = {
        "<Cmd>Telescope git_commits<CR>",
        "Search git commits",
      },
      ["telescope.recent_files"] = {
        "<Cmd>Telescope oldfiles<CR>",
        "Search recent files",
      },
      ["telescope.document_symbols"] = {
        "<Cmd>Telescope lsp_document_symbols<CR>",
        "Search document symbols",
      },
      ["telescope.workspace_symbols"] = {
        "<Cmd>Telescope lsp_workspace_symbols<CR>",
        "Search workspace symbols",
      },
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
    minv.keybindings[m]:apply(true, src, { mode = m })
  end
end

return M
