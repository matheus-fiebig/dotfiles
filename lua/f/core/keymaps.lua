vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

vim.cmd [[nnoremap <c-d> <nop>]]
vim.cmd [[nnoremap # <nop>]]
vim.cmd [[nnoremap <leader>c <nop>]]

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
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<CR>")
keymap.set("n", "<leader>gf", "<cmd>Telescope git_status<CR>")

-- nvim terminal
keymap.set("t", "<esc>", "<C-\\><C-N>", { desc = "Go to normal mode in terminal" })
keymap.set({ "n", "v" }, "<leader>ft", "<cmd>terminal<CR>", { desc = "Toggle terminal" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>l", "<cmd>BufferNext<CR>", { noremap = true, silent = true, desc = "Go to next tab" })
keymap.set("n", "<leader>c", "<cmd>BufferClose!<CR>", { noremap = true, silent = true, desc = "Go to next tab" })
keymap.set("n", "<leader>h", "<cmd>BufferPrevious<CR>", { noremap = true, silent = true, desc = "Go to previous tab" })
keymap.set("n", "<leader>n", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })
keymap.set("n", "<C-d>", "<C-W>>", { desc = "Increase window size" })
keymap.set("n", "<C-a>", "<C-W><", { desc = "Decrease window Size" })
keymap.set("n", "<C-s>", "<C-W>=", { desc = "Equalize window Size" })

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


-- tree view
keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

--ufo
vim.cmd [[nnoremap <C-f> <nop>]]
keymap.set('n', '<C-f>', "za")

--octo
vim.cmd [[nnoremap <C-o> <nop>]]
keymap.set('n', '<C-o>', "<cmd>Octo actions<CR>")

--easy motion
vim.cmd [[nmap f <Plug>(easymotion-bd-f)]]

vim.cmd [[nnoremap <c-z> <nop>]]
