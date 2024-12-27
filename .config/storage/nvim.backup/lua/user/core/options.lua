-- ████████████████████████████████████████████████████████
-- █▌                                                    ▐█
-- █▌ ░█▀█░█▀█░▀█▀░▀█▀░█▀█░█▀█░█▀▀░░░█▀▀░█▀▀░▀█▀░█░█░█▀█ ▐█
-- █▌ ░█░█░█▀▀░░█░░░█░░█░█░█░█░▀▀█░░░▀▀█░█▀▀░░█░░█░█░█▀▀ ▐█
-- █▌ ░▀▀▀░▀░░░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀░░░▀▀▀░▀▀▀░░▀░░▀▀▀░▀░░ ▐█
-- █▌                                                    ▐█
-- ████████████████████████████████████████████████████████

-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- The font used in graphical neovim applications
vim.opt.guifont = "JetBrainsMono Nerd Font Regular:h15"

-- Line Numbers
vim.opt.relativenumber = true    -- show relative line numbers
vim.opt.number = true            -- shows absolute line number on cursor line (when relative number is on)
vim.opt.numberwidth = 4          -- minimum number of columns to use for the line number (default is 2)

-- Tabs & Indentation
vim.opt.tabstop = 2           -- 2 spaces for tabs (prettier default)
vim.opt.shiftwidth = 2        -- 2 spaces for indent width
vim.opt.expandtab = true      -- expand tab to spaces
vim.opt.autoindent = true     -- copy indent from current line when starting new one
vim.opt.smartindent = true    -- automatic indentation

-- Search Settings
vim.opt.ignorecase = true    -- ignore case when searching
vim.opt.smartcase = true     -- if you include mixed case in your search, assumes you want case-sensitive
vim.opt.hlsearch = true      -- highlight all matches on previous search pattern

-- Backspace
vim.opt.backspace = "indent,eol,start"    -- allow backspace on indent, end of line or insert mode start position

-- Clipboard
vim.opt.clipboard = "unnamedplus"    -- allows neovim to access the system clipboard

-- Mouse Options
vim.opt.mouse = "a"          -- allow the mouse to be used in neovim
vim.opt.mousefocus = true    -- window focus follows mouse pointer
vim.opt.mousehide = true     -- hide mouse pointer while typing text

-- Swap / Backup / Undo
vim.opt.swapfile = false       -- creates a swapfile
vim.opt.backup = false         -- creates a backup file
vim.opt.writebackup = false    -- if a file is being edited by another program, it is not allowed to be edited
vim.opt.undofile = true        -- enable persistent undo

-- Encoding Type
vim.opt.encoding = "utf-8"        --  the default encoding for the current buffer 
vim.scriptencoding = "utf-8"      -- the encoding used for reading and writing vim scripts
vim.opt.fileencoding = "utf-8"    --  the encoding used for reading and writing files

-- Insert Mode
vim.opt.completeopt = { "menuone", "noselect" }    -- mostly just for cmp

-- Update Time / Timeout
vim.opt.updatetime = 300     -- faster completion (4000ms default)
vim.opt.timeoutlen = 1000    -- time to wait for a mapped sequence to complete (in milliseconds)

-- Show Options
vim.opt.showmode = false    -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 0     -- always show tabs
vim.opt.showcmd = false     -- show (partial) command in the last line of the screen.  Set to false if your terminal is slow.

-- Command Line
vim.opt.cmdheight = 0    -- more space in the neovim command line for displaying messages
vim.opt.ruler = false    -- show the line and column number of the cursor position

-- Status Line
vim.opt.laststatus = 3    -- Set global status line

-- Line Wrapping
vim.opt.wrap = false          -- disable line wrapping
vim.opt.linebreak = true      -- wrap long lines at a character in 'breakat'
vim.opt.breakindent = true    -- line is visually indented
vim.opt.showbreak = "  ﬌ "    -- indicator that is put in front of wrapped lines

-- Preview Substitutions
vim.opt.inccommand = 'split'

-- Cursor
vim.opt.cursorline = false         -- highlight the current cursor line
vim.opt.virtualedit = "onemore"    -- allow visual mode to go over end of lines

-- True Color Terminal Settings
vim.opt.termguicolors = true
vim.opt.background = "dark"      -- colorschemes that can be light or dark will be made dark
vim.opt.signcolumn = "yes:1"     -- show sign column so that text doesn't shift
vim.opt.colorcolumn = "99999"    -- fixes indentline for now

-- Split Windows
vim.opt.splitright = true    -- split vertical window to the right
vim.opt.splitbelow = true    -- split horizontal window to the bottom

-- Popup Menu
-- vim.opt.pumheight = 10    -- max number of items to show in the popup menu
-- vim.opt.pumblend = 10     -- enables pseudo-transparency

-- Scrolloff
vim.opt.scrolloff = 8        -- minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 8    -- Minimal number of screen lines to keep to the right and left of the cursor

-- Display Whitespace Characters
vim.opt.list = false
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Organize Later
vim.opt.iskeyword:append("-")                      -- consider string-string as whole word
vim.opt.conceallevel = 0                           -- so that `` is visible in markdown files
vim.opt.foldmethod = "manual"                      -- folding set to "expr" for treesitter based folding
vim.opt.foldexpr = ""                              -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
vim.opt.spell = false
vim.opt.spelllang = "en_us"
vim.opt.title = true                               -- set the title of window to the value of the titlestring
vim.opt.titlestring = "%<%F%=%l/%L - nvim"         -- what the title of the window will be set to
vim.opt.hidden = true                              -- required to keep multiple buffers and open multiple buffers
vim.opt.fillchars.eob = " "                        -- show empty lines at the end of a buffer as ` ` {default `~`}
-- vim.opt.shortmess:append "c"                    -- hide all the completion messages
-- vim.opt.whichwrap:append("<,>,[,],h,l")         -- keys allowed to move to the previous/next line when the beginning/end of line is reached
vim.opt.formatoptions:remove({ "c", "r", "o" })    -- This is a sequence of letters which describes how automatic formatting is to be done

vim.opt.guicursor = {
  "n-v-c:block",                                     -- Normal, visual, command-line: block cursor
  "i-ci-ve:ver25",                                   -- Insert, command-line insert, visual-exclude: vertical bar cursor with 25% width
  "r-cr:hor20",                                      -- Replace, command-line replace: horizontal bar cursor with 20% height
  "o:hor50",                                         -- Operator-pending: horizontal bar cursor with 50% height
  "a:blinkwait700-blinkoff400-blinkon250",           -- All modes: blinking settings
  "sm:block-blinkwait175-blinkoff150-blinkon175",    -- Showmatch: block cursor with specific blinking settings
}

vim.g.netrw_banner = 0
vim.g.netrw_mouse = 2
