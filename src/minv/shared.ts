import { PRESETS, update_preset } from "./presets";
import { PLUGINS, extend_plugins, Plug } from "./plugins";
import { KEYBINDINGS, update_keybindings } from "./keybindings";
import { CONFIG } from "./config";
import { AUTOCMDS } from "./autocmds";
import { SETTINGS } from "./settings";
import { autocmd, set_keymap } from "./utils";

export const ALL_PLUGINS = {} as LuaMap<string, Plug>;

export type MINV = typeof MINV;

function forward_func<A extends any[], R>(
  this: void,
  f: (this: void, ...args: A) => R
) {
  return function (...args: A): R {
    return f(...args);
  };
}

export const MINV = {
  config: CONFIG,
  plugins: PLUGINS,
  presets: PRESETS,
  keybindings: KEYBINDINGS,
  settings: SETTINGS,
  autocmds: AUTOCMDS,
  get_plugin(name: string): Plug | undefined {
    return ALL_PLUGINS.get(name);
  },
  set_keymap: forward_func(set_keymap),
  set_autocmd: forward_func(autocmd),
  update_plugins: forward_func(extend_plugins),
  update_keybindings: forward_func(update_keybindings),
  update_preset: forward_func(update_preset),
};
