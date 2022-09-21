/// <reference types="lua-types/jit" />
/// <reference types="spark/types" />

type AnyTbl = {
  [k: string]: AnyTbl;
} & ((this: void, ...args: any[]) => any);

declare namespace vim {
  const g: { [k: string]: any };
  const o: { [k: string]: any };

  interface keymap_opts {
    noremap?: boolean;
    nowait?: boolean;
    silent?: boolean;
    script?: boolean;
    expr?: boolean;
    unique?: boolean;
    desc?: string;
    callback?: (this: void) => void;
  }

  interface autocmd_opts {
    group?: string | number;
    pattern?: string | string[];
    buffer?: number;
    desc?: string;
    callback?: (this: void, args: autocmd_cb_args) => true | void;
    command?: string;
    once?: boolean;
    nested?: boolean;
  }

  interface autocmd_cb_args {
    id: number;
    event: string;
    group?: number;
    match: string;
    buf: number;
    file: string;
  }

  namespace api {
    const nvim_set_keymap: Lua.MkFn<
      (mode: string, lhs: string, rhs: string, opts?: keymap_opts) => void
    >;

    const nvim_buf_set_keymap: Lua.MkFn<
      (
        buffer: number,
        mode: string,
        lhs: string,
        rhs: string,
        opts?: Partial<keymap_opts>
      ) => void
    >;

    const nvim_create_autocmd: Lua.MkFn<
      (this: void, event: string | string[], opts: autocmd_opts) => number
    >;
  }
}
