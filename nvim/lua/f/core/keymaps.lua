vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

vim.cmd [[nnoremap <c-d> <nop>]]
vim.cmd [[nnoremap # <nop>]]
-- general
keymap.set({ "n", "v" }, "<CR>", ":noh<CR><CR>", { desc = "Clear search highlights" })
keymap.set({ "n", "v" }, "<C-Right>", "e", { desc = "Jump word" })
keymap.set({ "n", "v" }, "<C-Left>", "b", { desc = "Jump word" })
keymap.set({ "n", "v" }, "<C-l>", "e", { desc = "Jump word" })
keymap.set({ "n", "v" }, "<C-h>", "b", { desc = "Jump word" })
keymap.set({ "n", "v" }, "{", "{", { desc = "Jump word" })
keymap.set({ "n", "v" }, "#", "}", { desc = "Jump word" })
keymap.set("n", "<leader>~", "<cmd>e#<CR>", { desc = "PreviousFile" })

-- telescope
keymap.set("n", "<leader>H", ":Telescope commands<CR>")
keymap.set("n", "<leader>fb", ":Telescope file_browser<CR>")
keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
keymap.set("n", "<leader>fc", "<cmd>Telescope live_grep<cr>")

-- nvim terminal
keymap.set("t", "<esc>", "<C-\\><C-N>", { desc = "Go to normal mode in terminal" })
keymap.set({ "n", "v" }, "<leader>ft", "<cmd>terminal<CR>", { desc = "Toggle terminal" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>l", "<cmd>tabn<CR>", { noremap = true, silent = true, desc = "Go to next tab" })
keymap.set("n", "<leader>h", "<cmd>tabp<CR>", { noremap = true, silent = true, desc = "Go to previous tab" })
keymap.set("n", "<leader>n", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })
keymap.set("n", "<C-d>", "<C-W>>", { desc = "Increase window size" })
keymap.set("n", "<C-a>", "<C-W><", { desc = "Decrease window Size" })
keymap.set("n", "<C-s>", "<C-W>=", { desc = "Equalize window Size" })

-- copy and paste
keymap.set({ "n", "v" }, "f", "y", { desc = "Copy the current text" })

--code actions
keymap.set("n", "<leader>.", vim.lsp.buf.code_action, { desc = "Code actions" })
keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, { desc = "Format" })
keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "Go to declaration" })
keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename" })

-- trouble
keymap.set("n", "<leader>tr", "<cmd>Trouble<CR>", { desc = "Trouble" })

-- debug
vim.cmd [[nnoremap <F5> <nop>]]
keymap.set("n", "<leader>5", ":DapContinue<CR>")
keymap.set("n", "<leader>7", ":DapStepOver<CR>")
keymap.set("n", "<leader>8", ":DapStepInto<CR>")
keymap.set("n", "<leader>9", ":DapToggleBreakpoint<CR>")
keymap.set("n", "K", vim.lsp.buf.hover)

-- tree view
keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })

--ufo
vim.cmd [[nnoremap <C-f> <nop>]]
keymap.set('n', '<C-f><C-f>', "<cmd>foldopen<CR>")
keymap.set('n', '<C-f>', "<cmd>foldclose<CR>")

--refactor
vim.keymap.set(
    {"n", "x"},
    "<leader>rr",
    function() require('refactoring').select_refactor() end
)

vim.cmd [[nnoremap <c-z> <nop>]]
