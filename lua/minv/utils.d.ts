export { deep_merge } from "spark/utils";
export declare function plug_key(this: void, name: string): string;
export declare function mkHint<T>(this: void): <U extends T>(this: void, u: U) => U;
export declare function autocmd(this: void, event: string | string[], pattern: string | string[], cmd: string | NonNullable<vim.autocmd_opts["callback"]>, opts?: Omit<vim.autocmd_opts, "pattern" | "command" | "callback">): void;
