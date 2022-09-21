import { KeymapCmd, KeymapOpts, MkUpdater } from "./utils";
export interface Source extends KeymapOpts {
    cmd: KeymapCmd;
}
declare type ConcatKey<K, Pref extends string> = K extends string ? `${Pref}.${K}` : "12";
declare type MkBindingsKey<T, K extends keyof T> = K extends string ? ConcatKey<keyof T[K], K> : never;
declare type MkExtraKey<K> = K extends string ? ConcatKey<"extra", K> : never;
declare type MkKeybindigsInput = {
    [k: string]: {
        [k: string]: string[];
    };
};
declare type MkKeybindigs<T extends MkKeybindigsInput> = {
    [K in MkBindingsKey<T, keyof T>]: string[];
} & {
    [K in MkExtraKey<keyof T>]: {
        [k: string]: Source;
    };
};
declare const __INPUT: {
    normal: {
        nohlsearch: string[];
        save: string[];
    };
    insert: {
        escape: string[];
    };
    tree: {
        toggle: string[];
        focus: string[];
    };
    bufferline: {
        close: string[];
        goto_next: string[];
        goto_prev: string[];
    };
    telescope: {
        buffers: string[];
        document_symbols: string[];
        files: string[];
        git_commits: string[];
        grep: string[];
        marks: string[];
        recent_files: string[];
        registers: string[];
        workspace_symbols: string[];
    };
    git: {
        blame_line: string[];
        goto_next_hunk: string[];
        goto_prev_hunk: string[];
        preview_hunk: string[];
        reset_buffer: string[];
        reset_line: string[];
        stage_buffer: string[];
        state_hunk: string[];
        undo_stage_hunk: string[];
    };
    comment: {
        insert_above: string[];
        insert_below: string[];
        insert_eol: string[];
        oplead_block: string[];
        oplead_line: string[];
        toggle_block: string[];
        toggle_line: string[];
    };
    terminal: {
        toggle: string[];
    };
    lsp: {
        formatting: string[];
        goto_declaration: string[];
        goto_definition: string[];
        goto_next_diagnostic: string[];
        goto_next_error: string[];
        goto_prev_diagnostic: string[];
        goto_prev_error: string[];
        hover: string[];
        rename: string[];
        show_code_action: string[];
        show_diagnostic: string[];
        show_document_diagnostics: string[];
        show_implementation: string[];
        show_references: string[];
        show_signature_help: string[];
        show_workspace_diagnostics: string[];
    };
    cmp: {
        close: string[];
        complete: string[];
        confirm: string[];
        scroll_down: string[];
        scroll_up: string[];
        select_next: string[];
        select_prev: string[];
    };
};
declare type BindingKeys = MkBindingsKey<typeof __INPUT, keyof typeof __INPUT>;
declare type ExtraKeys = MkExtraKey<keyof typeof __INPUT>;
export declare type KEYBINDINGS = typeof KEYBINDINGS;
export declare const KEYBINDINGS: MkKeybindigs<{
    normal: {
        nohlsearch: string[];
        save: string[];
    };
    insert: {
        escape: string[];
    };
    tree: {
        toggle: string[];
        focus: string[];
    };
    bufferline: {
        close: string[];
        goto_next: string[];
        goto_prev: string[];
    };
    telescope: {
        buffers: string[];
        document_symbols: string[];
        files: string[];
        git_commits: string[];
        grep: string[];
        marks: string[];
        recent_files: string[];
        registers: string[];
        workspace_symbols: string[];
    };
    git: {
        blame_line: string[];
        goto_next_hunk: string[];
        goto_prev_hunk: string[];
        preview_hunk: string[];
        reset_buffer: string[];
        reset_line: string[];
        stage_buffer: string[];
        state_hunk: string[];
        undo_stage_hunk: string[];
    };
    comment: {
        insert_above: string[];
        insert_below: string[];
        insert_eol: string[];
        oplead_block: string[];
        oplead_line: string[];
        toggle_block: string[];
        toggle_line: string[];
    };
    terminal: {
        toggle: string[];
    };
    lsp: {
        formatting: string[];
        goto_declaration: string[];
        goto_definition: string[];
        goto_next_diagnostic: string[];
        goto_next_error: string[];
        goto_prev_diagnostic: string[];
        goto_prev_error: string[];
        hover: string[];
        rename: string[];
        show_code_action: string[];
        show_diagnostic: string[];
        show_document_diagnostics: string[];
        show_implementation: string[];
        show_references: string[];
        show_signature_help: string[];
        show_workspace_diagnostics: string[];
    };
    cmp: {
        close: string[];
        complete: string[];
        confirm: string[];
        scroll_down: string[];
        scroll_up: string[];
        select_next: string[];
        select_prev: string[];
    };
}>;
export declare type Mappings = {
    [K in BindingKeys]?: Source;
};
export declare function map_bindings(this: void, mappings: {
    [K in BindingKeys]?: any;
}): {
    [k: string]: any;
};
export declare function apply_mappings(this: void, mappings: Mappings, gopts?: KeymapOpts): void;
export declare function apply_extra(this: void, key: ExtraKeys, gopts?: KeymapOpts): void;
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
export declare function setup_keybindings(this: void): void;
export declare function update_keybindings(this: void, updater: MkUpdater<KEYBINDINGS, true>): void;
export {};
