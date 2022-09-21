import * as spark from "spark";
import { setup_autocmds } from "./autocmds";
import { setup_keybindings } from "./keybindings";
import { collect_plugins } from "./plugins";
import { setup_settings } from "./settings";
import { ALL_PLUGINS, MINV } from "./shared";
import { deep_merge } from "./utils";

export function setup_spark(this: void): typeof spark {
  return require("spark");
}

function load_plugins(this: void) {
  // Load plugins.
  const plugs = collect_plugins();
  const opts: DeepParitial<spark.Config> = {
    1(use) {
      for (const [_, plug] of ipairs(plugs)) {
        use(plug);
      }
    },
    // log: { level: "DEBUG" },
  };
  const spark = setup_spark();
  spark.setup(deep_merge("keep", opts, MINV.presets.spark));
  for (const [_, plug] of ipairs(spark.plugins())) {
    ALL_PLUGINS.set(plug[1], plug);
  }
  spark.load();
  spark.post_load();
}

export function setup(this: void, custom: (this: void, minv: MINV) => void) {
  // Apply customization.
  custom(MINV);
  // Apply settings.
  setup_settings();
  // Load plugins.
  load_plugins();
  // Apply keybindings.
  setup_keybindings();
  // Setup autocmds.
  setup_autocmds();
}
