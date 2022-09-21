import { PRESETS, Presets } from "./presets";
import { PLUGINS, Plugins } from "./plugins";
import { KEYBINDINGS, Keybindgs } from "./keybindings";
import { Config } from "./config";
import { Autocmds } from "./autocmds";
import { Settings } from "./settings";
export interface GeneralMiNV<TPlugins = Plugins, TPresets = Presets, TKeybindgs = Keybindgs> {
    config: Config;
    plugins: TPlugins;
    presets: TPresets;
    keybindings: TKeybindgs;
    settings: Settings;
    autocmds: Autocmds;
}
export declare type MINV = GeneralMiNV<typeof PLUGINS, typeof PRESETS, typeof KEYBINDINGS>;
export declare const MINV: MINV;
