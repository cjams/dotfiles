if vim.g.vscode then
    -- VSCode Neovim
    require "user.vscode_keymaps"
    vim.opt.hlsearch = false
else
    -- Ordinary Neovim
end