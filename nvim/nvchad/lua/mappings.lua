require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "<C-p>", ":Telescope find_files <CR>")
map("n", "<C-S-p>", ":Telescope find_files follow=true no_ignore=true hidden=true <CR>")
map("n", "<C-f>", ":Telescope live_grep <CR>")
map("n", "<leader>fx", ":Telescope grep_string <CR>")
map("n", "<C-h>", "<cmd> bprev <CR>")
map("n", "<C-l>", "<cmd> bnext <CR>")
