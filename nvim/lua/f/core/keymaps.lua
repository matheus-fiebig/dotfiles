vim.g.mapleader = "\\"

local keymap = vim.keymap                                                       -- for conciseness
local api = vim.api                                                             -- for conciseness

-- general
keymap.set({ "n", "v" }, "<CR>", ":noh<CR><CR>", { desc = "Clear search highlights" })

-- telescope
keymap.set("n", "<leader>H", ":Telescope commands<CR>", { desc = "Exit insert mode with jk" })
keymap.set("n", "<leader>ff", ":Telescope file_browser<CR>", { desc = "Exit insert mode with jk" })
keymap.set("n", "<leader>fc", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })

-- nvim terminal
keymap.set("t", "<esc>", "<C-\\><C-N>", { desc = "Go to normal mode in terminal" })
keymap.set({ "n", "v" }, "<leader>ft", ":FloatermToggle<CR>", { desc = "Toggle terminal" })

-- window management
--keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
--keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>l", "<cmd>tabn<CR>", { noremap = true, silent = true, desc = "Go to next tab" })
keymap.set("n", "<leader>h", "<cmd>tabp<CR>", {  noremap = true, silent = true, desc = "Go to previous tab" })
keymap.set("n", "<leader>n", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- copy and paste
keymap.set({ "n", "v" }, "f", "y", { desc = "Copy the current text" })

--quickfix
keymap.set("n", "<leader>qf", "<cmd>copen<CR>", {desc = "Open quickfix"})
keymap.set({ "n", "v" }, "[q", "<cmd>cprev<CR>", { desc = "Prev quickfix" })
keymap.set({ "n", "v" }, "]q", "<cmd>cnext<CR>", { desc = "Next quickfix" })

--code actions
keymap.set("n", "<leader>.", vim.lsp.buf.code_action, { desc = "Code actions" })
keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, { desc = "Format" })
keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "Go to declaration" })
keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename" })

-- hoper
keymap.set("n", "<leader>e", "<cmd>HopWord<CR>", { desc = "Hop" })

-- trouble
keymap.set("n", "<leader>tr", "<cmd>TroubleToggle<CR>", { desc = "Trouble" })

-- debug
vim.cmd [[nnoremap <F5> <nop>]]
keymap.set("n", "<F5>", ":DapContinue<CR>")
keymap.set("n", "<F9>", ":DapToggleBreakpoint<CR>")
keymap.set("n", "<F10>", ":DapStepOver<CR>")
keymap.set("n", "<F11>", ":DapStepInto<CR>")
keymap.set("n", "<F17>", ":DapTerminate<CR>")
keymap.set("n", "K", vim.lsp.buf.hover)

-- tree view
keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })

vim.cmd [[nnoremap <c-z> <nop>]]
