-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  local result = vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
  if vim.v.shell_error ~= 0 then
    -- stylua: ignore
    vim.api.nvim_echo({ { ("Error cloning lazy.nvim:\n%s\n"):format(result), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
    vim.fn.getchar()
    vim.cmd.quit()
  end
end

vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

vim.keymap.set("n", "<space>f", "mzggVG=`zzz", { desc = "Format entire buffer" })
vim.keymap.set("n", "<space>s", ":w<CR>", { desc = "Save file" })
--vim.keymap.set("n", "<space>s", ":w | Stdheader<CR>", { desc = "Save file and update header" })
vim.keymap.set("n", "<space>s", function()
    vim.cmd("Stdheader")
    vim.cmd("w")
end, { desc = "Update header and save file" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python", "c", "cpp" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = false -- use spaces, recommended for Python
  end,
})

require "lazy_setup"
require "polish"

vim.g.user = "cbozkurt"
vim.g.mail = "cbozkurt@student.42kocaeli.com.tr"
