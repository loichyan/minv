import { map_bindings } from "../keybindings";
import { PRESETS } from "../presets";
import { deep_merge } from "../utils";

export function setup(this: void) {
  const cmp = require("cmp") as AnyTbl;
  const luasnip = require("luasnip") as AnyTbl;
  // Collect mappings for `nvim-cmp`.
  const cmp_mapping = cmp.mapping;
  function locally_jumpable(this: void, dire: number): boolean {
    return luasnip.jumpable(dire) && luasnip.in_snippet();
  }
  const mapping = map_bindings({
    "cmp.close": cmp_mapping.close(),
    "cmp.complete": cmp_mapping.complete(),
    "cmp.confirm": cmp_mapping.confirm({ select: true }),
    "cmp.scroll_down": cmp_mapping.scroll_docs(4),
    "cmp.scroll_up": cmp_mapping.scroll_docs(-4),
    "cmp.select_next": cmp_mapping((fb: AnyTbl) => {
      if (cmp.visible()) {
        cmp.select_next_item();
      } else if (luasnip.expandable()) {
        luasnip.expand();
      } else if (locally_jumpable(1)) {
        luasnip.jump(1);
      } else {
        fb();
      }
    }),
    "cmp.select_prev": cmp_mapping((fb: AnyTbl) => {
      if (cmp.visible()) {
        cmp.select_prev_item();
      } else if (locally_jumpable(-1)) {
        luasnip.jump(-1);
      } else {
        fb();
      }
    }),
  });
  // Collect options for nvim-cmp.
  const bordered = cmp.config.window.bordered();
  const cmp_opts = deep_merge("keep", { mapping }, PRESETS.cmp, {
    window: {
      completion: bordered,
      documentation: bordered,
    },
    confirmation: {
      default_behavior: cmp.ConfirmBehavior.Replace,
    },
  });
  // Setup `luasnip`.
  luasnip.config.setup(PRESETS.luasnip);
  // Setup `nvim-cmp`
  cmp.setup(cmp_opts);
  // Load snippets (e.g. friendly-snippets)
  (require("luasnip.loaders.from_vscode") as AnyTbl).lazy_load();
}
