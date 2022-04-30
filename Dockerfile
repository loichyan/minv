FROM alpine:edge as neovim
COPY . /minv
RUN apk update && \
    apk add gcc g++ make curl tar gzip unzip git neovim

FROM neovim as minv
RUN rm -rf /minv/plugin /minv/lua/custom /minv/lua/custom.lua && \
    cp /minv/examples/custom.lua /minv/lua/custom.lua && \
    mkdir -p ~/.config && \
    ln -s /minv ~/.config/nvim && \
    nvim --headless -c "autocmd User PackerComplete quitall" -c PackerSync &> /dev/null
ENTRYPOINT nvim
