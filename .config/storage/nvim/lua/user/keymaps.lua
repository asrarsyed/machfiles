-- ████████████████████████████████████████████████████████
-- █▌                                                    ▐█
-- █▌ ░█░█░█▀▀░█░█░█▄█░█▀█░█▀█░█▀▀░░░█▀▀░█▀▀░▀█▀░█░█░█▀█ ▐█
-- █▌ ░█▀▄░█▀▀░░█░░█░█░█▀█░█▀▀░▀▀█░░░▀▀█░█▀▀░░█░░█░█░█▀▀ ▐█
-- █▌ ░▀░▀░▀▀▀░░▀░░▀░▀░▀░▀░▀░░░▀▀▀░░░▀▀▀░▀▀▀░░▀░░▀▀▀░▀░░ ▐█
-- █▌                                                    ▐█
-- ████████████████████████████████████████████████████████

local opts = { silent = true }

-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("", "<Space>", "<Nop>", { silent = true })

-- Shorten function name
local keymap = vim.keymap.set