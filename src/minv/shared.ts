import { PRESETS, Presets } from "./presets";
import { PLUGINS, Plugins } from "./plugins";
import { KEYBINDINGS, Keybindgs } from "./keybindings";
import { Config, CONFIG } from "./config";
import { Autocmds, AUTOCMDS } from "./autocmds";
import { Settings, SETTINGS } from "./settings";

export interface GeneralMiNV<
  TPlugins = Plugins,
  TPresets = Presets,
  TKeybindgs = Keybindgs
> {
  config: Config;
  plugins: TPlugins;
  presets: TPresets;
  keybindings: TKeybindgs;
  settings: Settings;
  autocmds: Autocmds;
}

export type MINV = GeneralMiNV<
  typeof PLUGINS,
  typeof PRESETS,
  typeof KEYBINDINGS
>;

export const MINV: MINV = {
  config: CONFIG,
  plugins: PLUGINS,
  presets: PRESETS,
  keybindings: KEYBINDINGS,
  settings: SETTINGS,
  autocmds: AUTOCMDS,
};
