-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- Iterate over all Lua files in the plugins directory and load them
local plugins_dir = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'custom', 'plugins')
for file_name, type in vim.fs.dir(plugins_dir, { follow = true }) do
  if (type == 'file' or type == 'link') and file_name:match '%.lua$' and file_name ~= 'init.lua' then
    local module = file_name:gsub('%.lua$', '')
    require('custom.plugins.' .. module)
  end
end

-- Create custom command to check Lsp status
vim.api.nvim_create_user_command('LspInfo', ':checkhealth vim.lsp', { desc = 'Alias to `:checkhealth vim.lsp`' })

-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.o.relativenumber = true

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)
-- vim.o.clipboard = 'unnamedplus'
vim.opt.clipboard:append("unnamedplus") -- use system clipboard as default register
vim.g.clipboard = {
	name = "xclip",
	copy = {
		["+"] = { "xclip", "-quiet", "-i", "-selection", "clipboard" },
		["*"] = { "xclip", "-quiet", "-i", "-selection", "primary" },
	},
	paste = {
		["+"] = { "xclip", "-o", "-selection", "clipboard" },
		["*"] = { "xclip", "-o", "-selection", "primary" },
	},
	cache_enabled = 1, -- cache MUST be enabled, or else it hangs on dd/y/x and all other copy operations
}

vim.lsp.config('robotframework_ls', {
settings = {
	robot = {
		-- lint = {
		--   robocop = {
		--     enabled = true, -- Enables Robocop integration
		--   },
		-- },
		['language-server'] = {
			python = vim.fn.exepath("python3"),
		},
		variables = {
			-- Set EXECDIR explicitly if static resolution fails in your workspace
			EXECDIR = vim.fn.getcwd() .. '/src',
		},
		pythonpath = {
			vim.fn.getcwd() .. '/src',
			vim.fn.getcwd() .. '/../ampere-robotframework-dev/src',
			vim.fn.exepath("python3"),
		}
	}
},
})
