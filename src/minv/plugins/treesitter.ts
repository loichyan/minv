import { apply_mappings, Source, mkPlugKeySrc } from "../keybindings";
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

function pre_hook(this: void, ctx: any) {
  const comment_utils = require("Comment.utils") as AnyTbl;
  const cmstring_utils = require("ts_context_commentstring.utils") as AnyTbl;
  let key = "__default";
  if (ctx.ctype != comment_utils.ctype.line) {
    key = "__multiline";
  }
  let location;
  if (ctx.ctype == comment_utils.ctype.block) {
    location = cmstring_utils.get_cursor_location();
  } else if (
    ctx.cmotion == comment_utils.cmotion.v ||
    ctx.motion == comment_utils.cmotion.V
  ) {
    location = cmstring_utils.get_visual_start_location();
  }
  return (
    require("ts_context_commentstring.internal") as AnyTbl
  ).calculate_commentstring({
    key,
    location,
  });
}

const COMMENT_DEFAULT = {
  pre_hook,
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
  (require("Comment") as AnyTbl).setup(
    deep_merge("keep", {}, COMMENT_DEFAULT, PRESETS.comment)
  );
  apply_mappings(MAPPINGS.toggle, { noremap: false });
  apply_mappings(MAPPINGS.oplead, { mode: "x", noremap: false });
  apply_mappings(MAPPINGS.insert, { noremap: false });
}

export function setup_surround(this: void) {
  (require("nvim-surround") as AnyTbl).setup(PRESETS.surround);
}
