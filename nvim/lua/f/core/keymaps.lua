vim.g.mapleader = "\\"

local keymap = vim.keymap -- for conciseness
local api = vim.api       -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- nvim terminal
keymap.set("t", "<esc>", "<C-\\><C-N>", { desc = "Go to normal mode in terminal" })
keymap.set({ "n", "v" }, "<leader>ft", ":FloatermToggle<CR>", { desc = "Toggle terminal" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- window management
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- copy and paste
keymap.set({ "n", "v" }, "f", "y", { desc = "Copy the current text" })

--code actions
keymap.set("n", "<leader>.", vim.lsp.buf.code_action, { desc = "Code actions" })
keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, { desc = "Format" })
keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "Go to declaration" })
keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename" })

-- hoper
keymap.set("n", "<leader>e", "<cmd>HopWord<CR>", { desc = "Hop" })

-- trouble
keymap.set("n", "<leader>tr", "<cmd>Trouble<CR>", { desc = "Trouble" })

-- debug
vim.cmd [[nnoremap <F5> <nop>]]
keymap.set("n", "<F5>", ":DapContinue<CR>")
keymap.set("n", "<F9>", ":DapToggleBreakpoint<CR>")
keymap.set("n", "<F10>", ":DapStepOver<CR>")
keymap.set("n", "<F11>", ":DapStepInto<CR>")
keymap.set("n", "<F17>", ":DapTerminate<CR>")
keymap.set("n", "K", vim.lsp.buf.hover)

vim.cmd [[nnoremap <c-z> <nop>]]
