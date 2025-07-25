vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

vim.cmd [[nnoremap <c-d> <nop>]]
vim.cmd [[nnoremap <c-e> <nop>]]
vim.cmd [[nnoremap <c-q> <nop>]]
vim.cmd [[nnoremap # <nop>]]
vim.cmd [[nnoremap <leader>c <nop>]]
vim.cmd [[nnoremap <leader>dn <nop>]]
vim.cmd [[nnoremap <leader>rf <nop>]]
vim.cmd [[nnoremap <c-z> <nop>]]
vim.cmd [[nnoremap <C-g> <nop>]]
vim.cmd [[nnoremap <C-f> <nop>]]
vim.cmd [[nnoremap <F5> <nop>]]
vim.cmd [[nnoremap S <nop>]]

-- general
keymap.set({ "n", "v" }, "<CR>", ":noh<CR><CR>", { desc = "Clear search highlights" })
keymap.set({ "n", "v" }, "<C-Right>", "e", { desc = "Jump word" })
keymap.set({ "n", "v" }, "<C-Left>", "b", { desc = "Jump word" })
keymap.set({ "n", "v" }, "<C-l>", "e", { desc = "Jump word" })
keymap.set({ "n", "v" }, "<C-h>", "b", { desc = "Jump word" })
keymap.set({ "n", "v" }, "{", "{", { desc = "Jump word" })
keymap.set({ "n", "v" }, "#", "}", { desc = "Jump word" })
keymap.set("n", "<leader>~", "<cmd>e#<CR>", { desc = "PreviousFile" })
keymap.set('n', '<C-f>', "za", { desc = "Folding" })

-- telescope
keymap.set("n", "<leader>H", function() require 'telescope.builtin'.commands() end)
keymap.set("n", "<leader>ff",
    function() require 'telescope.builtin'.find_files() end)
keymap.set("n", "<leader>fc",
    function() require 'telescope.builtin'.live_grep() end)
keymap.set("n", "<leader>gf",
    function() require 'telescope.builtin'.git_status() end)

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
keymap.set("n", "<C-q>", "<C-W>+", { desc = "Increase window size vertically" })
keymap.set("n", "<C-d>", "<C-W>>", { desc = "Increase window size horziontally" })
keymap.set("n", "<C-e>", "<C-W>-", { desc = "Decrease window size vertically" })
keymap.set("n", "<C-a>", "<C-W><", { desc = "Decrease window size horziontally" })
keymap.set("n", "<C-s>", "<C-W>=", { desc = "Equalize window size " })

--lsp / dap
keymap.set("n", "<leader>.", vim.lsp.buf.code_action, { desc = "Code actions" })
keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, { desc = "Format" })
keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "Go to declaration" })
keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
keymap.set('n', '<leader>rf', "<cmd>Telescope lsp_references <CR>", { desc = "Go to definition" })
keymap.set("n", "<leader>a", "<cmd>Telsecope lsp_document_symbols<CR>", { desc = "Toggle symbols" })
keymap.set('n', '<leader>dn', "<cmd>Trouble diagnostics toggle focus=true<cr>",
    { desc = "Go to definition" })
keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename" })
keymap.set("n", "<F5>", ":DapContinue<CR>")
keymap.set("n", "<F9>", ":DapToggleBreakpoint<CR>")
keymap.set("n", "<F10>", ":DapStepOver<CR>")
keymap.set("n", "<F11>", ":DapStepInto<CR>")
keymap.set("n", "K", vim.lsp.buf.hover)
keymap.set("n", "T", function()
    if require("dap").status() ~= nil then
        local word_under_cursor = vim.fn.expand("<cword>")
        require("dapui").eval(word_under_cursor)
    end
end)
--keymap.set('n', '<leader>g', ":lua require'dap'.goto()<CR>", { noremap = true, silent = true }) No support for C#

-- tree view
keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

--octo
keymap.set('n', '<C-g>', "<cmd>Octo actions<CR>")

--easy motion
vim.cmd [[nmap E <Plug>(easymotion-bd-f)]]
