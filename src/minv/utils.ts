export { deep_merge } from "spark/utils";

// TODO: add same function with strict type checks aims to update tables
export function merge<
  B extends "force" | "keep",
  T1 extends Tbl,
  Rest extends Tbl[]
>(
  this: void,
  behavior: B,
  t1: T1,
  ...rest: Rest
): MergeTbls<T1, Rest, B extends "force" ? true : false, false> {
  const tbl1 = t1 as any as LuaTable<string | number>;
  for (const [_, tbl2] of ipairs(rest as any as LuaTable<string | number>[])) {
    for (const [k, v2] of pairs(tbl2)) {
      const v1 = tbl1.get(k);
      if (behavior == "force") {
        if (v2 != undefined) tbl1.set(k, v2);
      } else if (v1 == undefined) {
        tbl1.set(k, v2);
      }
    }
  }
  return tbl1 as any;
}

export function plug_key(this: void, name: string) {
  return string.format("<Plug>(minv.%s)", name);
}

export function mkHint<T>(this: void) {
  return function <U extends T>(this: void, u: U) {
    return u;
  };
}

export function autocmd(
  this: void,
  event: string | string[],
  cmd: string | NonNullable<vim.autocmd_opts["callback"]>,
  opts?: Omit<vim.autocmd_opts, "command" | "callback">
) {
  let command, callback;
  if (type(cmd) == "string") {
    command = cmd;
  } else if (type(cmd) == "function") {
    callback = cmd;
  }
  const options = vim.tbl_extend("keep", { command, callback }, opts ?? {});
  vim.api.nvim_create_autocmd(event, options as any);
}

export type KeymapCmd = string | Lua.MkFn<() => void>;

type VOpts = Omit<vim.keymap_opts, "callback">;

export interface KeymapOpts extends VOpts {
  mode?: string;
  buffer?: number;
}

const DEFAULT_VIM_OPTS: { [K in keyof VOpts]-?: VOpts[K] | -1 } = {
  noremap: true,
  nowait: -1,
  silent: true,
  script: -1,
  expr: -1,
  unique: -1,
  desc: -1,
};

const DEFAULT_MODE = "n";

export function set_keymap(
  this: void,
  lhs: string,
  cmd: KeymapCmd,
  opts: KeymapOpts
) {
  // Figure out whether use callback;
  let rhs: string, callback: vim.keymap_opts["callback"];
  if (type(cmd) == "string") {
    rhs = cmd as string;
  } else {
    rhs = "";
    callback = cmd as any;
  }
  const vopts: vim.keymap_opts = {
    callback,
  };
  // Collect vim options except `callback`.
  for (const [k, v] of pairs(DEFAULT_VIM_OPTS)) {
    const v2 = opts[k];
    vopts[k] = (v2 == undefined && v != -1 ? v : v2) as any;
  }
  const mode = opts.mode ?? DEFAULT_MODE;
  const buffer = opts.buffer;
  if (buffer != undefined) {
    vim.api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, vopts);
  } else {
    vim.api.nvim_set_keymap(mode, lhs, rhs, vopts);
  }
}

type Table = { [k: string | number]: any };

type MkAction<T, Strict = false> =
  | { $set: T | (Strict extends true ? never : any) }
  | {
      $merge:
        | (T extends Table ? Partial<T> : never)
        | (Strict extends true ? never : Table);
    }
  | {
      $concat:
        | (T extends any[] ? T : never)
        | (Strict extends true ? never : any[]);
    }
  | {
      $insert: [
        number,
        (
          | (T extends (infer E)[] ? E : never)
          | (Strict extends true ? never : any)
        )
      ];
    }
  | { $batch: MkAction<T, Strict>[] };

export type MkUpdater<T, Strict = false> =
  | { [K in keyof T]?: MkAction<T[K], Strict> | MkUpdater<T[K], Strict> }
  | (Strict extends true
      ? never
      : {
          [k: number | string]: MkAction<any, Strict> | MkUpdater<any, Strict>;
        });

function apply_act<T, K extends keyof T>(
  this: void,
  tbl: T,
  key: K,
  act: MkAction<T[K]>
): boolean {
  if ("$set" in act) {
    tbl[key] = act.$set;
    return true;
  } else if ("$merge" in act) {
    merge("force", tbl[key] as Table, act.$merge);
    return true;
  } else if ("$concat" in act) {
    vim.list_extend(tbl[key] as any[], act.$concat);
    return true;
  } else if ("$insert" in act) {
    const [pos, val] = act.$insert;
    table.insert(tbl[key] as any[], pos, val);
    return true;
  } else if ("$batch" in act) {
    for (const [_, a] of ipairs(act.$batch)) {
      apply_act(tbl, key, a);
    }
    return true;
  } else {
    return false;
  }
}

export function apply_updater<T>(this: void, tbl: T, updater: MkUpdater<T>) {
  for (const [key, act] of pairs(updater as any as LuaTable<keyof T, any>)) {
    if (!apply_act(tbl, key, act)) {
      let oldval = tbl[key] as any;
      if (type(oldval) != "table") {
        tbl[key] = oldval = {} as any;
      }
      apply_updater(oldval, act);
    }
  }
}
