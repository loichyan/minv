import { apply_mappings, Mappings } from "../keybindings";
import { PRESETS } from "../presets";
import { deep_merge } from "../utils";

declare global {
  namespace vim {
    const lsp: AnyTbl;
  }
}

const MAPPINGS: Mappings = {
  "lsp.formatting": {
    cmd: "<Cmd>lua vim.lsp.buf.formatting()<CR>",
    desc: "Formatting",
  },
  "lsp.goto_declaration": {
    cmd: "<Cmd>lua vim.lsp.buf.declaration()<CR>",
    desc: "Goto declaration",
  },
  "lsp.goto_definition": {
    cmd: "<Cmd>lua vim.lsp.buf.definition()<CR>",
    desc: "Goto definition",
  },
  "lsp.goto_next_diagnostic": {
    cmd: "<Cmd>lua vim.diagnostic.goto_next()<CR>",
    desc: "Goto next diagnostic",
  },
  "lsp.goto_next_error": {
    cmd: "<Cmd>lua vim.diagnostic.goto_next({ severity : vim.diagnostic.severity.ERROR })<CR>",
    desc: "Goto next error",
  },
  "lsp.goto_prev_diagnostic": {
    cmd: "<Cmd>lua vim.diagnostic.goto_prev()<CR>",
    desc: "Goto prev diagnostic",
  },
  "lsp.goto_prev_error": {
    cmd: "<Cmd>lua vim.diagnostic.goto_prev({ severity : vim.diagnostic.severity.ERROR })<CR>",
    desc: "Goto prev error",
  },
  "lsp.hover": {
    cmd: "<Cmd>lua vim.lsp.buf.hover()<CR>",
    desc: "Hover",
  },
  "lsp.rename": {
    cmd: "<Cmd>lua vim.lsp.buf.rename()<CR>",
    desc: "Rename",
  },
  "lsp.show_code_action": {
    cmd: "<Cmd>lua vim.lsp.buf.code_action()<CR>",
    desc: "Show code action",
  },
  "lsp.show_diagnostic": {
    cmd: "<Cmd>lua vim.diagnostic.open_float()<CR>",
    desc: "Show diagnostic",
  },
  "lsp.show_document_diagnostics": {
    cmd: "<Cmd>lua vim.diagnostic.setloclist()<CR>",
    desc: "Show document diagnostics",
  },
  "lsp.show_implementation": {
    cmd: "<Cmd>lua vim.lsp.buf.implementation()<CR>",
    desc: "Show implementation",
  },
  "lsp.show_references": {
    cmd: "<Cmd>lua vim.lsp.buf.references()<CR>",
    desc: "Show references",
  },
  "lsp.show_signature_help": {
    cmd: "<Cmd>lua vim.lsp.buf.signature_help()<CR>",
    desc: "Show signature help",
  },
  "lsp.show_workspace_diagnostics": {
    cmd: "<Cmd>lua vim.diagnostic.setqflist()<CR>",
    desc: "Show workspace diagnostics",
  },
};

function on_attach(this: void, client: AnyTbl, buffer: number) {
  if ((client.resolved_capabilities.document_highlight as any) == true) {
    vim.cmd(`
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold,CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved,CursorMovedI,InsertEnter <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    `);
  }
  apply_mappings(MAPPINGS, { buffer });
}

export function setup_lspconfig(this: void) {
  // Update capabilities.
  const [ok, cmp_nvim_lsp] = pcall(require, "cmp_nvim_lsp");
  let capabilities = vim.lsp.protocol.make_client_capabilities();
  if (ok) {
    capabilities = (cmp_nvim_lsp as AnyTbl).update_capabilities(capabilities);
  }
  // Setup Lsp servers.
  const preset = PRESETS.lspconfig;
  for (const [name, conf] of pairs(preset.servers)) {
    const opts = deep_merge(
      "keep",
      {
        on_attach: function (this: void, client: AnyTbl, buffer: number) {
          on_attach(client, buffer);
          if (conf.on_attach != undefined) {
            conf.on_attach();
          }
        },
        capabilities,
      },
      preset.server_default
    );
    (require("lspconfig") as AnyTbl)[name].setup(opts);
  }
  // Set border of popup windows.
  const open_floating_preview = vim.lsp.util.open_floating_preview;
  (vim.lsp.util.open_floating_preview as any) = (
    contents: any,
    syntax: any,
    opts: AnyTbl,
    ...args: any[]
  ) => {
    opts = opts ?? {};
    opts.border = opts.border ?? preset.border;
    return open_floating_preview(contents, syntax, opts, ...args);
  };
  // Set border of `LspInfo`.
  require("lspconfig.ui.windows").default_options.border = "single";
}

export function setup_null_ls(this: void) {
  const null_ls = require("null-ls") as AnyTbl;
  // Collect `null-ls` sources.
  const sources: {}[] = [];
  const preset_sources = PRESETS.null_ls_sources;
  for (const [k, v] of pairs(preset_sources.formatters)) {
    table.insert(sources, null_ls.builtins.formatting[k].with(v));
  }
  for (const [k, v] of pairs(preset_sources.linters)) {
    table.insert(sources, null_ls.builtins.diagnostics[k].with(v));
  }
  // Setup `null-ls`.
  null_ls.setup(deep_merge("keep", { on_attach, sources }, PRESETS.null_ls));
}
