declare global {
    namespace vim {
        const lsp: AnyTbl;
    }
}
export declare function setup_lspconfig(this: void): void;
export declare function setup_null_ls(this: void): void;
