import * as _main from "./minv/main";
export { type MINV } from "./minv/shared";

export const setup: typeof _main.setup = (custom) => {
  // Setup impatient.
  pcall(require, "impatient");
  // Apply customization.
  (require("./minv/main") as typeof import("./minv/main")).setup(custom);
};
