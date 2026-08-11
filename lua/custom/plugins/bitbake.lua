-- The tool `lanaguage-server-bitbake` is hosted at 'https://github.com/yoctoproject/vscode-bitbake'
-- This tool should be install by Mason by append this to
--  vim.list_extend(ensure_installed, {
--   -- You can add other tools here that you want Mason to install
--   'language-server-bitbake'
-- })
-- NOTE: Need to do this becasue the bitbake_language_server of nvim-lspconfig is a different tool
-- and it is not in the registry list of Mason.

-- Below is the config to Bitbake LSP
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*.bb", "*.bbappend", "*.bbclass", "*.inc", "conf/*.conf" },
  callback = function()
    vim.lsp.start({
      name = "bitbake",
      cmd = { "language-server-bitbake", "--stdio" }
    })
  end,
})
