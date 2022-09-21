import { Config as SparkConfig } from "spark/shared";
import * as _keybindings from "./minv/keybindings";
import * as _plugins from "./minv/plugins";
import * as _presets from "./minv/presets";
import * as _utils from "./minv/utils";
import * as _spark from "./minv/spark";
import * as _settings from "./minv/settings";
import * as _autocmds from "./minv/autocmds";
import * as _shared from "./minv/shared";

function load_plugins(this: void) {
  const plugins = require("./minv/plugins") as typeof _plugins;
  const presets = (require("./minv/presets") as typeof _presets).PRESETS.spark;
  const utils = require("./minv/utils") as typeof _utils;
  const spark = (require("./minv/spark") as typeof _spark).setup();
  // Load plugins.
  const plugs = plugins.collect_plugins();
  const opts: DeepParitial<SparkConfig> = {
    1(use) {
      for (const [_, plug] of ipairs(plugs)) {
        use(plug);
      }
    },
  };
  spark.setup(utils.deep_merge("keep", opts, presets));
  spark.load();
  spark.post_load();
}

export function setup(
  this: void,
  custom: (this: void, minv: _shared.MINV) => void
) {
  // Setup impatient.
  pcall(require, "impatient");
  // Apply customization.
  custom((require("./minv/shared") as typeof _shared).MINV);
  // Apply settings.
  (require("./minv/settings") as typeof _settings).setup();
  // Load plugins.
  load_plugins();
  // Apply keybindings.
  (require("./minv/keybindings") as typeof _keybindings).setup();
  // Setup autocmds.
  (require("./minv/autocmds") as typeof _autocmds).setup();
}
