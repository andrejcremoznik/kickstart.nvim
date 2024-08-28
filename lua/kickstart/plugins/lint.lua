return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      lint.linters_by_ft = lint.linters_by_ft or {}
      lint.linters_by_ft['sh'] = { 'shellcheck' }
      lint.linters_by_ft['bash'] = { 'shellcheck' }
      lint.linters_by_ft['php'] = { 'phpstan' }
      -- lint.linters_by_ft['javascript'] = { 'eslint_d' }
      -- lint.linters_by_ft['javascriptreact'] = { 'eslint_d' }
      lint.linters_by_ft['javascript'] = { 'eslint' }
      lint.linters_by_ft['javascriptreact'] = { 'eslint' }

      -- Disable the default linters
      lint.linters_by_ft['clojure'] = nil
      lint.linters_by_ft['dockerfile'] = nil
      lint.linters_by_ft['inko'] = nil
      lint.linters_by_ft['janet'] = nil
      lint.linters_by_ft['json'] = nil
      lint.linters_by_ft['markdown'] = nil
      lint.linters_by_ft['rst'] = nil
      lint.linters_by_ft['ruby'] = nil
      lint.linters_by_ft['terraform'] = nil
      lint.linters_by_ft['text'] = nil

      -- eslint_d v9 support
      -- lint.linters.eslint_d.args = vim.tbl_extend('force', {
      --   '--config',
      --   function ()
      --     return vim.fn.getcwd() .. 'eslint.config.js'
      --   end,
      -- }, lint.linters.eslint_d.args)

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
