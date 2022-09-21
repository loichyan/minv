import {
  apply_mappings,
  Source,
  mkPlugKeySrc,
  apply_extra,
} from "../keybindings";
import { PRESETS } from "../presets";
import { deep_merge } from "../utils";

const MAPPINGS = {
  toggle: mkPlugKeySrc({
    "comment.toggle_line": "Toggle line comments",
    "comment.toggle_block": "Toggle block comments",
  }),
  oplead: mkPlugKeySrc({
    "comment.oplead_line": "Toggle line comments",
    "comment.oplead_block": "Toggle block comments",
  }),
  insert: mkPlugKeySrc({
    "comment.insert_above": "Insert comments above",
    "comment.insert_below": "Insert comments below",
    "comment.insert_eol": "Insert comments eol",
  }),
};

function mkMappingsForComment(
  this: void,
  target: keyof typeof MAPPINGS
): { [k: string]: string } {
  const trim = "comment._".length + target.length + 1;
  const mappings: { [k: string]: string } = {};
  for (const [name, src] of pairs(
    MAPPINGS[target] as { [k: string]: Source }
  )) {
    mappings[string.sub(name as string, trim)] = src.cmd as string;
  }
  return mappings as any;
}

const COMMENT_DEFAULT = {
  toggler: mkMappingsForComment("toggle"),
  opleader: mkMappingsForComment("oplead"),
  extra: mkMappingsForComment("insert"),
  mappings: {
    basic: true,
    extra: true,
    extended: false,
  },
};

export function setup_treesitter(this: void) {
  (require("nvim-treesitter.configs") as AnyTbl).setup(PRESETS.treesitter);
}

export function setup_comment(this: void) {
  const pre_hook = (
    require("ts_context_commentstring.integrations.comment_nvim") as AnyTbl
  ).create_pre_hook();
  (require("Comment") as AnyTbl).setup(
    deep_merge("keep", { pre_hook }, COMMENT_DEFAULT, PRESETS.comment)
  );
  apply_mappings(MAPPINGS.toggle, { noremap: false });
  apply_mappings(MAPPINGS.oplead, { mode: "x", noremap: false });
  apply_mappings(MAPPINGS.oplead, { noremap: false });
  apply_mappings(MAPPINGS.insert, { noremap: false });
  apply_extra("comment.extra", { mode: "n" });
}

export function setup_surround(this: void) {
  (require("nvim-surround") as AnyTbl).setup(PRESETS.surround);
}
