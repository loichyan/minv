import * as _spark from "spark";

export function setup(this: void): typeof _spark {
  const req = require;
  const spark = req("spark") as typeof _spark;
  return spark;
}
