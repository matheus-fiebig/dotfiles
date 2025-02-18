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
keymap.set({ "n", "v" }, "s", "f", { desc = "Find foward" })
keymap.set({ "n", "v" }, "S", "F", { desc = "Find backwards" })

-- telescope
keymap.set("n", "<leader>H", ":Telescope commands<CR>")
--keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
--keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<CR>")
keymap.set("n", "<leader>ff", "<cmd>lua Snacks.picker.files()<CR>")
keymap.set("n", "<leader>fc", "<cmd>lua Snacks.picker.grep()<CR>")
keymap.set("n", "<leader>gf", "<cmd>Telescope git_status<CR>")

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

-- debug
vim.cmd [[nnoremap <F5> <nop>]]
keymap.set("n", "<leader>5", ":DapContinue<CR>")
keymap.set("n", "8", ":DapStepOver<CR>")
keymap.set("n", "9", ":DapStepInto<CR>")
keymap.set("n", "<leader>9", ":DapToggleBreakpoint<CR>")
--keymap.set('n', '<leader>g', ":lua require'dap'.goto()<CR>", { noremap = true, silent = true }) C# does not support
keymap.set("n", "K", vim.lsp.buf.hover)
keymap.set("n", "T", function() Show_variable_values() end)

-- tree view
keymap.set("n", "<leader>ee",
    "<cmd>NvimTreeOpen<CR><cmd>NvimTreeClose<CR><cmd>lua Snacks.explorer.open({replace_netrw = true})<CR>",
    { desc = "Toggle file explorer" })

--ufo
vim.cmd [[nnoremap <C-f> <nop>]]
keymap.set('n', '<C-f><C-f>', "<cmd>foldopen<CR>")
keymap.set('n', '<C-f>', "<cmd>foldclose<CR>")

vim.cmd [[nnoremap <c-z> <nop>]]
