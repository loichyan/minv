import { apply_extra, apply_mappings, Mappings } from "../keybindings";
import { PRESETS } from "../presets";
import { autocmd, deep_merge } from "../utils";

const MAPPINGS: Mappings = {
  "lsp.formatting": {
    cmd: () => vim.lsp.buf.formatting(),
    desc: "Formatting",
  },
  "lsp.goto_declaration": {
    cmd: () => vim.lsp.buf.declaration(),
    desc: "Goto declaration",
  },
  "lsp.goto_definition": {
    cmd: () => vim.lsp.buf.definition(),
    desc: "Goto definition",
  },
  "lsp.goto_next_diagnostic": {
    cmd: () => vim.diagnostic.goto_next(),
    desc: "Goto next diagnostic",
  },
  "lsp.goto_next_error": {
    cmd: () =>
      vim.diagnostic.goto_next({ severity: vim.diagnostic.severity.ERROR }),
    desc: "Goto next error",
  },
  "lsp.goto_prev_diagnostic": {
    cmd: () => vim.diagnostic.goto_prev(),
    desc: "Goto prev diagnostic",
  },
  "lsp.goto_prev_error": {
    cmd: () =>
      vim.diagnostic.goto_prev({ severity: vim.diagnostic.severity.ERROR }),
    desc: "Goto prev error",
  },
  "lsp.hover": {
    cmd: () => vim.lsp.buf.hover(),
    desc: "Hover",
  },
  "lsp.rename": {
    cmd: () => vim.lsp.buf.rename(),
    desc: "Rename",
  },
  "lsp.show_code_action": {
    cmd: () => vim.lsp.buf.code_action(),
    desc: "Show code action",
  },
  "lsp.show_diagnostic": {
    cmd: () => vim.diagnostic.open_float(),
    desc: "Show diagnostic",
  },
  "lsp.show_document_diagnostics": {
    cmd: () => vim.diagnostic.setloclist(),
    desc: "Show document diagnostics",
  },
  "lsp.show_implementation": {
    cmd: () => vim.lsp.buf.implementation(),
    desc: "Show implementation",
  },
  "lsp.show_references": {
    cmd: () => vim.lsp.buf.references(),
    desc: "Show references",
  },
  "lsp.show_signature_help": {
    cmd: () => vim.lsp.buf.signature_help(),
    desc: "Show signature help",
  },
  "lsp.show_workspace_diagnostics": {
    cmd: () => vim.diagnostic.setqflist(),
    desc: "Show workspace diagnostics",
  },
};

function on_attach(this: void, client: AnyTbl, buffer: number) {
  if ((client.resolved_capabilities.document_highlight as any) == true) {
    autocmd("CursorHold,CursorHoldI", () => vim.lsp.buf.document_highlight(), {
      buffer,
    });
    autocmd(
      "CursorMoved,CursorMovedI,InsertEnter",
      () => vim.lsp.buf.clear_references(),
      { buffer }
    );
  }
  apply_mappings(MAPPINGS, { buffer });
  apply_extra("lsp.extra", { mode: "n", buffer });
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
            conf.on_attach(client, buffer);
          }
        },
        capabilities,
      },
      preset.server_default
    );
    (require("lspconfig") as AnyTbl)[name].setup(opts);
  }
  // Set border of popup windows.
  const border = preset.border;
  const open_floating_preview = vim.lsp.util.open_floating_preview;
  (vim.lsp.util.open_floating_preview as any) = function (
    this: void,
    contents: any,
    syntax: any,
    opts: AnyTbl,
    ...args: any[]
  ) {
    opts = opts ?? {};
    opts.border = border == undefined ? opts.border : (border as any);
    return open_floating_preview(contents, syntax, opts, ...args);
  };
  // Set border of `LspInfo`.
  require("lspconfig.ui.windows").default_options.border = border;
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
