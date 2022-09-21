/**
 * CheckKeys<{a:any,b:any}, ["a", "b", "c"]> = ["a", "b", never]
 */
export type CheckKeys<T, TKeys, TPref extends string = ""> = TKeys extends [
  infer THead,
  ...infer TTail
]
  ? THead extends string
    ? `${TPref}${THead}` extends keyof T
      ? [THead, ...CheckKeys<T, TTail, TPref>]
      : [never, ...CheckKeys<T, TTail, TPref>]
    : [never, ...CheckKeys<T, TTail, TPref>]
  : TKeys;

export type CheckPath<T, TPath> = TPath extends [infer THead, ...infer TTail]
  ? THead extends keyof T
    ? [THead, ...CheckPath<T, TTail>]
    : [CheckKeys<T, THead>, ...CheckPath<T, TTail>]
  : TPath;

/**
 * TupleToUnion<["a", "b", "c"]> = "a" | "b" | "c"
 */
export type TupleToUnion<T> = T extends [infer THead, ...infer TTail]
  ? THead | TupleToUnion<TTail>
  : T extends []
  ? never
  : T;

/**
 * TupleToObj<T,["a", "b"]> = {a:T,b:T}
 */
export type TupleToObj<T, TKeys = []> = TKeys extends [
  infer T1st,
  ...infer TTail
]
  ? T1st extends string
    ? { [K in T1st]: T } & TupleToObj<T, TTail>
    : {}
  : {};
