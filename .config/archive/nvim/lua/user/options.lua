-- ████████████████████████████████████████████████████████
-- █▌                                                    ▐█
-- █▌ ░█▀█░█▀█░▀█▀░▀█▀░█▀█░█▀█░█▀▀░░░█▀▀░█▀▀░▀█▀░█░█░█▀█ ▐█
-- █▌ ░█░█░█▀▀░░█░░░█░░█░█░█░█░▀▀█░░░▀▀█░█▀▀░░█░░█░█░█▀▀ ▐█
-- █▌ ░▀▀▀░▀░░░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀░░░▀▀▀░▀▀▀░░▀░░▀▀▀░▀░░ ▐█
-- █▌                                                    ▐█
-- ████████████████████████████████████████████████████████

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
vim.opt.incsearch = true     -- show search matches as you type

-- Backspace
vim.opt.backspace = "indent,eol,start"    -- allow backspace on indent, end of line or insert mode start position

-- Clipboard
vim.opt.clipboard = "unnamedplus"    -- allows neovim to access the system clipboard

-- Mouse Options
vim.opt.mouse = "a"          -- allow the mouse to be used in neovim
vim.opt.mousefocus = true    -- window focus follows mouse pointer

-- Swap / Backup / Undo
vim.opt.swapfile = false       -- disable swapfile
vim.opt.backup = false         -- disable backup file creation
vim.opt.writebackup = false    -- disable write backup for safety with external edits
vim.opt.undofile = true        -- enable persistent undo

-- Encoding Type
vim.opt.encoding = "utf-8"        -- default encoding for current buffer 
vim.opt.fileencoding = "utf-8"    -- encoding for file reading and writing

-- Insert Mode
vim.opt.completeopt = { "menuone", "noselect" }    -- mainly for completion plugin behavior

-- Update Time / Timeout
vim.opt.updatetime = 200     -- faster completion (4000ms default)
vim.opt.timeoutlen = 500    -- time to wait for a mapped sequence to complete (in milliseconds)

-- Show Options
vim.opt.showmode = false    -- hide mode indicator (e.g., -- INSERT --)
vim.opt.showtabline = 0     -- hide tab line
vim.opt.showcmd = false     -- hide command display in the last line

-- Command Line
vim.opt.cmdheight = 0    -- reduce command line height for more screen space
vim.opt.ruler = false    -- hide cursor position in the status line

-- Status Line
vim.opt.laststatus = 3    -- set a global status line

-- Line Wrapping
vim.opt.wrap = false          -- disable line wrapping
vim.opt.linebreak = true      -- wrap at convenient character (not mid-word)
vim.opt.breakindent = true    -- visually indent wrapped lines
vim.opt.showbreak = "  ﬌ "    -- indicate wrapped lines

-- Preview Substitutions
vim.opt.inccommand = 'split'

-- Cursor
vim.opt.cursorline = false         -- disable cursor line highlighting
vim.opt.virtualedit = "onemore"    -- allow cursor to move beyond end of line

-- True Color Terminal Settings
vim.opt.termguicolors = true
vim.opt.background = "dark"      -- set background to dark
vim.opt.signcolumn = "yes:1"     -- show sign column
-- vim.opt.colorcolumn = "80"    -- fixes indentline for now

-- Split Windows
vim.opt.splitright = true    -- split vertical window to the right
vim.opt.splitbelow = true    -- split horizontal window to the bottom

-- Popup Menu
vim.opt.pumheight = 10    -- max items to show in popup menu
vim.opt.pumblend = 10     -- enables pseudo-transparency

-- Scrolloff
vim.opt.scrolloff = 8        -- minimal lines above/below cursor
vim.opt.sidescrolloff = 8    -- minimal columns left/right of cursor

-- Display Whitespace Characters
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Text Editing and Word Navigation
vim.opt.iskeyword:append("-")                  -- Treat string-string as a single word
vim.opt.hidden = true                          -- Allow switching buffers without saving
-- vim.opt.formatoptions:remove({ "c", "r", "o" }) -- Customize auto-formatting behavior
vim.opt.formatoptions = "jqlnt"  -- j:remove comment leader when joining, q:allow formatting of comments with gq, l:don't format already long lines, n:recognize numbered lists, t:auto-wrap text using textwidth

-- Folding
vim.opt.foldmethod = "manual"                  -- Set manual folding
vim.opt.foldexpr = ""                          -- Set fold expression (leave empty for manual folding)

-- Spell Check
vim.opt.spell = false                          -- Disable spell checking
vim.opt.spelllang = "en_us"                    -- Set spell check language to US English

-- Display and Visuals
vim.opt.title = true                           -- Enable window title
vim.opt.titlestring = "%<%F%=%l/%L - nvim"     -- Set title format (file name and line info)
vim.opt.fillchars.eob = " "                    -- Show empty lines at end of buffer as spaces
vim.opt.conceallevel = 0                       -- Make `` visible in markdown files

-- Miscellaneous
-- vim.opt.shortmess:append("c")               -- Suppress completion messages
-- vim.opt.whichwrap:append("<,>,[,],h,l")     -- Enable line wrap movement

-- Cursor Style
vim.opt.guicursor = {
  "n-v-c:block",                                     -- Normal, visual, command-line: block cursor
  "i-ci-ve:ver25",                                   -- Insert, command-line insert, visual-exclude: vertical bar cursor with 25% width
  "r-cr:hor20",                                      -- Replace, command-line replace: horizontal bar cursor with 20% height
  "o:hor50",                                         -- Operator-pending: horizontal bar cursor with 50% height
  "a:blinkwait700-blinkoff400-blinkon250",           -- blinking settings for all modes
  "sm:block-blinkwait175-blinkoff150-blinkon175",    -- blinking for showmatch
}

vim.g.netrw_banner = 0    -- disable netrw banner
vim.g.netrw_mouse = 2     -- enable mouse support in netrw
