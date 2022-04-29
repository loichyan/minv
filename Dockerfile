FROM alpine:edge
COPY . /minv
RUN apk update && \
    apk add gcc g++ make curl tar gzip unzip git neovim
RUN rm -rf /minv/plugin /minv/lua/custom /minv/lua/custom.lua && \
    cp /minv/examples/example_init.lua /minv/lua/custom.lua && \
    mkdir -p ~/.config && \
    ln -s /minv ~/.config/nvim && \
    nvim --headless -c "autocmd User PackerComplete quitall" -c PackerSync &> /dev/null
ENTRYPOINT nvim
