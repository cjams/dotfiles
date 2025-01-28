local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- remap leader
-- clear any existing mapping for comma in normal mode
keymap("n", ",", "", opts)

vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- remap save and close file
keymap({"n", "v"}, "<leader>s", ':w<CR>', opts)
keymap({"n"}, "<leader>d", "<cmd>lua require('vscode').action('workbench.action.closeActiveEditor')<CR>", opts)

keymap({"n"}, "<leader>h", "<cmd>lua require('vscode').action('workbench.action.navigateLeft')<CR>", opts)
keymap({"n"}, "<leader>l", "<cmd>lua require('vscode').action('workbench.action.navigateRight')<CR>", opts)
keymap({"n"}, "<leader>k", "<cmd>lua require('vscode').action('workbench.action.navigateUp')<CR>", opts)
keymap({"n"}, "<leader>j", "<cmd>lua require('vscode').action('workbench.action.navigateDown')<CR>", opts)

keymap({"n"}, "<leader>e", "<cmd>lua require('vscode').action('workbench.action.splitEditor')<CR>", opts)
keymap({"n"}, "<leader>r", "<cmd>lua require('vscode').action('workbench.action.splitEditorDown')<CR>", opts)

-- quick fix menu
keymap("n", "<leader>a", "<cmd>lua require('vscode').action('editor.action.quickFix')<CR>", opts)

-- show hover
keymap({"n", "v"}, "<Space>h", "<cmd>lua require('vscode').action('editor.action.showHover')<CR>")

-- show problems
keymap({"n"}, "<leader>p", "<cmd>lua require('vscode').action('workbench.action.problems')<CR>")

-- quick open
keymap({"n", "v"}, "<leader>f", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>")

-- find in files
keymap({"n", "v"}, "<leader>?", "<cmd>lua require('vscode').action('workbench.action.findInFiles', {args = {query = vim.fn.expand('<cword>')}})<CR>")
