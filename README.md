# 🌱 MiNV

Extendable lightweight Neovim configuration framework written in TypeScript.

![startscreen](./assets/startscreen.png)

## 📌 Notice

This project was recently rewritten in TypeScript and transpiled to Lua using
[TypeScriptToLua](https://github.com/TypeScriptToLua/TypeScriptToLua), but I
found it a bit of a pain because I had to fight with the type system and it
often lead to hidden bugs when dealing with language differences, especially
`this` and `self`. Also, I don't want to bring in external code and take
advantage of Lua's built-in features as much as possible. Secondly, this project
deprecates [packer.nvim](https://github.com/wbthomason/packer.nvim) in favor of
[spark.nvim](https://github.com/loichyan/spark.nvim), because we need a dynamic
and sequential loading plugin manager but packer will compile your profile and
load it in parallel with `init.lua`. Therefore, the development of this project
will be suspended until [js2lua](https://github.com/loicyan/js2lua) is
available.

## 📝 Todo

- [x] Rewritten in TypeScript
- [ ] Extendable layers
- [ ] Core layer
- [ ] More layers

## ⚖️ License

This software is released under the either of [MIT License](LICENSE-MIT) or
[Apache License 2.0](LICENSE-APACHE) at your option.
