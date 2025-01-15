-- ██████████████████████████████████████████████████████
-- █▌                                                  ▐█
-- █▌ ░█▀█░█░█░▀█▀░█▀█░█▀▀░█▀█░█▄█░█▄█░█▀█░█▀█░█▀▄░█▀▀ ▐█
-- █▌ ░█▀█░█░█░░█░░█░█░█░░░█░█░█░█░█░█░█▀█░█░█░█░█░▀▀█ ▐█
-- █▌ ░▀░▀░▀▀▀░░▀░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀░▀░▀░▀░▀░▀░▀▀░░▀▀▀ ▐█
-- █▌                                                  ▐█
-- ██████████████████████████████████████████████████████

-- ╭────────────────────────────────────────────────────╮
-- │             HIGHLIGHT SELECTED TEXT                │
-- ╰────────────────────────────────────────────────────╯
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 100,
    })
  end,
  group = highlight_group,
  pattern = '*',
})


-- ╭────────────────────────────────────────────────────╮
-- │                   CLEAR HIGHLIGHTING               │
-- ╰────────────────────────────────────────────────────╯
vim.api.nvim_set_keymap('n', '<Esc>', ':noh<CR><Esc>', { noremap = true, silent = true })

-- ╭────────────────────────────────────────────────────╮
-- │                     SPELL CHECK                    │
-- ╰────────────────────────────────────────────────────╯
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

-- ╭────────────────────────────────────────────────────╮
-- │                    CHANGE CURSORLINE               │
-- ╰────────────────────────────────────────────────────╯
-- vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
--     callback = function()
--         vim.opt.cursorline = true
--     end,
-- })
--
-- vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
--     callback = function()
--         vim.opt.cursorline = false
--     end,
-- })

-- ╭────────────────────────────────────────────────────╮
-- │       DISABLE INLAY HINTS FOR SPECIFIC FILETYPES   │
-- ╰────────────────────────────────────────────────────╯
-- vim.api.nvim_create_autocmd('FileType', {
--     pattern = { 'zsh', 'conf' },
--     callback = function()
--         vim.lsp.inlay_hint.enable(0, false)
--     end,
-- })

-- ╭────────────────────────────────────────────────────╮
-- │  FORCE TREESITTER TO WORK WITH SPECIFIC FILESTYPES │
-- ╰────────────────────────────────────────────────────╯
-- vim.api.nvim_create_autocmd('FileType', {
--     pattern = { 'zsh', 'conf' },
--     callback = function()
--         vim.bo.filetype = 'sh'
--     end,
-- })

-- vim.filetype.add({
--     extension = {
--         sh = 'sh',
--         zsh = 'sh',
--         conf = 'sh',
--     },
--     filename = {
--         ['.zshrc'] = 'sh',
--         ['.zshenv'] = 'sh',
--         ['.conf'] = 'sh',
--     },
-- })

-- ╭────────────────────────────────────────────────────╮
-- │                QUIT SOME WINDOWS WITH Q            │
-- ╰────────────────────────────────────────────────────╯
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'help', 'qf', 'man', 'oil', 'aerial-nav', 'query' },
    callback = function()
        vim.keymap.set('n', 'q', '<cmd>bd<cr>', { silent = true, buffer = true })
    end,
})

-- ╭────────────────────────────────────────────────────╮
-- │                  QUIT DIFFVIEW WITH Q              │
-- ╰────────────────────────────────────────────────────╯
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'DiffViewFiles', 'checkhealth' },
    callback = function()
        vim.keymap.set('n', 'q', '<cmd>tabc<cr>', { silent = true, buffer = true })
    end,
})

-- ╭────────────────────────────────────────────────────╮
-- │                 OPEN HELP IN A NEW TAB             │
-- ╰────────────────────────────────────────────────────╯
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'help',
    command = ':wincmd T',
})

-- ╭────────────────────────────────────────────────────╮
-- │                      FORMATOPTIONS                 │
-- ╰────────────────────────────────────────────────────╯
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    callback = function()
        vim.opt.formatoptions:remove({ 'o', 'r', 'c' })
        vim.opt.formatoptions:append({ 't' })
    end,
})

-- ╭────────────────────────────────────────────────────╮
-- │       JUMP TO LAST EDIT POSITION ON OPENING FILE   │
-- ╰────────────────────────────────────────────────────╯
vim.api.nvim_create_autocmd('BufReadPost', {
    desc = 'Open file at the last position it was edited earlier',
    pattern = '*',
    command = 'silent! normal! g`"zv',
})

-- ╭────────────────────────────────────────────────────╮
-- │               MESSAGE IF MACRO IS STOPPED          │
-- ╰────────────────────────────────────────────────────╯
local macro_group = vim.api.nvim_create_augroup('MacroRecording', { clear = true })
vim.api.nvim_create_autocmd('RecordingLeave', {
    group = macro_group,
    callback = function()
        -- Display a message when macro recording stops
        print('Macro recording stopped')
    end,
})
