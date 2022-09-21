/// <reference types="spark/types" />
export { deep_merge } from "spark/utils";
export declare function merge<B extends "force" | "keep", T1 extends Tbl, Rest extends Tbl[]>(this: void, behavior: B, t1: T1, ...rest: Rest): MergeTbls<T1, Rest, B extends "force" ? true : false, false>;
export declare function plug_key(this: void, name: string): string;
export declare function mkHint<T>(this: void): <U extends T>(this: void, u: U) => U;
export declare function autocmd(this: void, event: string | string[], cmd: string | NonNullable<vim.autocmd_opts["callback"]>, opts?: Omit<vim.autocmd_opts, "command" | "callback">): void;
export declare type KeymapCmd = string | Lua.MkFn<() => void>;
declare type VOpts = Omit<vim.keymap_opts, "callback">;
export interface KeymapOpts extends VOpts {
    mode?: string;
    buffer?: number;
}
export declare function set_keymap(this: void, lhs: string, cmd: KeymapCmd, opts: KeymapOpts): void;
declare type Table = {
    [k: string | number]: any;
};
declare type MkAction<T, Strict = false> = {
    $set: T | (Strict extends true ? never : any);
} | {
    $merge: (T extends Table ? Partial<T> : never) | (Strict extends true ? never : Table);
} | {
    $concat: (T extends any[] ? T : never) | (Strict extends true ? never : any[]);
} | {
    $insert: [
        number,
        ((T extends (infer E)[] ? E : never) | (Strict extends true ? never : any))
    ];
} | {
    $batch: MkAction<T, Strict>[];
};
export declare type MkUpdater<T, Strict = false> = {
    [K in keyof T]?: MkAction<T[K], Strict> | MkUpdater<T[K], Strict>;
} | (Strict extends true ? never : {
    [k: number | string]: MkAction<any, Strict> | MkUpdater<any, Strict>;
});
export declare function apply_updater<T>(this: void, tbl: T, updater: MkUpdater<T>): void;
