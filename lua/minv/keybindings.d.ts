/// <reference types="spark/types" />
export declare type Binding = string[];
export declare type Keybindgs = {
    [k: string]: Binding;
};
export declare type KEYBINDINGS = typeof KEYBINDINGS;
export declare const KEYBINDINGS: {
    "normal.nohlsearch": string[];
    "normal.save": string[];
    "insert.escape": string[];
    "explorer.toggle": string[];
    "explorer.focus": string[];
    "buffer.close": string[];
    "buffer.goto_next": string[];
    "buffer.goto_prev": string[];
    "telescope.buffers": string[];
    "telescope.document_symbols": string[];
    "telescope.files": string[];
    "telescope.git_commits": string[];
    "telescope.grep": string[];
    "telescope.marks": string[];
    "telescope.recent_files": string[];
    "telescope.registers": string[];
    "telescope.workspace_symbols": string[];
    "git.blame_line": string[];
    "git.goto_next_hunk": string[];
    "git.goto_prev_hunk": string[];
    "git.preview_hunk": string[];
    "git.reset_buffer": string[];
    "git.reset_line": string[];
    "git.stage_buffer": string[];
    "git.state_hunk": string[];
    "git.undo_stage_hunk": string[];
    "comment.insert_above": string[];
    "comment.insert_below": string[];
    "comment.insert_eol": string[];
    "comment.oplead_block": string[];
    "comment.oplead_line": string[];
    "comment.toggle_block": string[];
    "comment.toggle_line": string[];
    "terminal.toggle": string[];
    "lsp.formatting": string[];
    "lsp.goto_declaration": string[];
    "lsp.goto_definition": string[];
    "lsp.goto_next_diagnostic": string[];
    "lsp.goto_next_error": string[];
    "lsp.goto_prev_diagnostic": string[];
    "lsp.goto_prev_error": string[];
    "lsp.hover": string[];
    "lsp.rename": string[];
    "lsp.show_code_action": string[];
    "lsp.show_diagnostic": string[];
    "lsp.show_document_diagnostics": string[];
    "lsp.show_implementation": string[];
    "lsp.show_references": string[];
    "lsp.show_signature_help": string[];
    "lsp.show_workspace_diagnostics": string[];
    "cmp.close": string[];
    "cmp.complete": string[];
    "cmp.confirm": string[];
    "cmp.scroll_down": string[];
    "cmp.scroll_up": string[];
    "cmp.select_next": string[];
    "cmp.select_prev": string[];
};
export interface KeybindingOpts extends Omit<vim.keymap_opts, "callback" | "desc"> {
}
export declare type BindingCmd = string | Lua.MkFn<() => void>;
declare let binding_handler: (this: void, mode: string, buffer: number | undefined, lhs: string, cmd: BindingCmd, desc: string, options: KeybindingOpts) => void;
export declare function set_handler(this: void, new_handler: typeof binding_handler): void;
export declare type SourceOpts = Partial<KeybindingOpts> & {
    mode?: string;
    buffer?: number;
};
export declare type Source = SourceOpts & {
    cmd: BindingCmd;
    desc: string;
};
export declare type Mappings = {
    [K in keyof KEYBINDINGS]?: Source;
};
export declare function map_bindings(this: void, mappings: {
    [K in keyof KEYBINDINGS]?: any;
}): {
    [k: string]: any;
};
export declare function apply_mappings(this: void, mappings: Mappings, gOpts?: SourceOpts): void;
export declare function mkPlugKeySrc<TNames extends keyof KEYBINDINGS>(this: void, descs: {
    [K in TNames]: string;
}): {
    [K in TNames]: Source;
};
export declare const COMMON_MAPPINGS: {
    "insert.escape": {
        cmd: string;
        desc: string;
        mode: string;
    };
    "normal.nohlsearch": {
        cmd: string;
        desc: string;
    };
    "normal.save": {
        cmd: string;
        desc: string;
    };
};
export declare function setup(this: void): void;
export {};
