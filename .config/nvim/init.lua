vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.swapfile = false
vim.o.wrap = true
vim.o.winborder = "rounded"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.textwidth = 80
vim.g.mapleader = " "

vim.pack.add({
	{src="https://github.com/nvim-lua/plenary.nvim"},
	{src="https://github.com/neovim/nvim-lspconfig"},
	{src="https://github.com/norcalli/nvim-colorizer.lua"},
	{src="https://github.com/nvim-treesitter/nvim-treesitter"},
	{src="https://github.com/windwp/nvim-autopairs"},
	{src="https://github.com/RRethy/base16-nvim"},
	{src="https://github.com/andrewferrier/wrapping.nvim"},
	{src="https://github.com/folke/which-key.nvim"},
	{src="https://github.com/mason-org/mason.nvim"},
	{src="https://github.com/nvim-mini/mini.pick"},
	{
		src="https://github.com/ThePrimeagen/harpoon",
		version = "harpoon2"
	},
	{src="https://github.com/stevearc/oil.nvim"},
	{src="https://github.com/ej-shafran/compile-mode.nvim"},
	{src="https://github.com/L3MON4D3/LuaSnip"},
	{src="https://github.com/hrsh7th/cmp-path"},
	{src="https://github.com/hrsh7th/cmp-nvim-lsp"},
	{src="https://github.com/hrsh7th/nvim-cmp"},
	{src="https://github.com/MeanderingProgrammer/render-markdown.nvim"},
	{src="https://github.com/chomosuke/typst-preview.nvim"},
})

require("nvim-treesitter.configs").setup {
	ensure_installed = { "c", "lua", "markdown", "nim", "gdscript" },
}

require("wrapping").setup()
require "mason".setup()
require "oil".setup ({
})
require "nvim-autopairs".setup()
require "mini.pick".setup()
require "render-markdown".setup()
require "typst-preview".setup()
local luasnip = require "luasnip"
luasnip.config.setup {}
local cmp = require"cmp"
cmp.setup()

cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	completion = { completeopt = 'menu,menuone,noinsert' },
	mapping = cmp.mapping.preset.insert {
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<Tab>'] = cmp.mapping.confirm { select = true },
		['<C-Space>'] = cmp.mapping.complete {},
	},
	sources = {
		{
			name = 'lazydev',
			group_index = 0,
		},
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'path' },
		{ name = 'nvim_lsp_signature_help' },
	},
}

vim.g.compile_mode = {}

-- require "mini.completion".setup()
local harpoon = require "harpoon".setup()
harpoon:setup {}

--[[


require('base16-colorscheme').setup {
	base00 = '#2f2925',
	base01 = '#534c4c', -- 10100e
	base02 = '#4f4a43',
	base03 = '#7b6f67', -- 6c7891
	base04 = '#565c64',
	base05 = '#bea0bd',
	base06 = '#d1d073',
	base07 = '#c5c8e6',
	base08 = '#b0957e',
	base09 = '#898dc3',
	base0A = '#c7ac5f',
	base0B = '#5fa072', -- 949fb4
	base0C = '#ab94ce',
	base0D = '#f17c79', -- b0957e
	base0E = '#75a9cc',
	base0F = '#d1d073',
}

]]--

require('base16-colorscheme').setup {
	base00 = '#24272b', -- background
	base01 = '#4e5855',
	base02 = '#4e5855', -- visual mode highlighting
	base03 = '#758983', -- 7b6f67
	base04 = '#758983',
	base05 = '#ca7978',
	base06 = '#babc74',
	base07 = '#b0bcbc', -- foreground text
	base08 = '#c27c9a',
	base09 = '#c5ac89',
	base0A = '#5084b0',
	base0B = '#81c1a9',
	base0C = '#7074b0',
	base0D = '#57a085',
	base0E = '#81afc1',
	base0F = '#c18e81',
}

vim.keymap.set("n", "<C-c>", ":vert:Compile ")

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set("n", "<C-f>", ":Pick files<CR>")
vim.keymap.set("n", "<C-g>", ":Pick grep_live<CR>")
vim.keymap.set("n", "<leader>h", ":Pick help<CR>")

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

vim.keymap.set("n", "<C-k>", ":lua vim.diagnostic.open_float()<CR>")
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "rn", vim.lsp.buf.rename)

local function format_paragraph()
    local original_pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd('normal! vapgw')
    vim.api.nvim_win_set_cursor(0, original_pos)
end

vim.keymap.set("n", "fm", format_paragraph);

vim.keymap.set("n", "<leader>f", ":Oil<CR>");

vim.lsp.enable({ "lua_ls", "clangd", "marksman", "tinymist", "nimls", "gdscript" })

vim.lsp.config("lua_ls",
{
    settings = {
        Lua = {
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            }
        }
    }
})

vim.diagnostic.enable = true;
vim.diagnostic.config({
	virtual_text = false
})

vim.api.nvim_create_user_command("OpenPdf", function()

    local filepath = vim.api.nvim_buf_get_name(0)

    if filepath:match("%.typ$") then

        local pdf_path = filepath:gsub("%.typ$", ".pdf")

        vim.system({ "zathura", pdf_path })

    end

end, {})

