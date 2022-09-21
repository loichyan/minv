export { deep_merge } from "spark/utils";

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
  pattern: string | string[],
  cmd: string | NonNullable<vim.autocmd_opts["callback"]>,
  opts?: Omit<vim.autocmd_opts, "pattern" | "command" | "callback">
) {
  const options: vim.autocmd_opts = vim.tbl_extend(
    "keep",
    { pattern },
    opts ?? {}
  );
  if (type(cmd) == "string") {
    options.command = cmd as any;
  } else if (type(cmd) == "function") {
    options.callback = cmd as any;
  }
  vim.api.nvim_create_autocmd(event, options);
}
