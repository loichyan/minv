import * as spark from "spark";
import { MINV } from "./shared";
export declare function setup_spark(this: void): typeof spark;
export declare function setup(this: void, custom: (this: void, minv: MINV) => void): void;
