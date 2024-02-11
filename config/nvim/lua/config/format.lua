-- Customize the "injected" formatter
require("conform").formatters.prettier = {
  -- Set the options field
  options = {
    -- Set individual option values
    ignore_errors = true,
    ft_parsers = {
         javascript = "babel",
         javascriptreact = "babel",
         typescript = "typescript",
         typescriptreact = "typescript",
         vue = "vue",
         css = "css",
         scss = "scss",
         less = "less",
         html = "html",
         json = "json",
         jsonc = "json",
         yaml = "yaml",
         markdown = "markdown",
    --     ["markdown.mdx"] = "mdx",
    --     graphql = "graphql",
    --     handlebars = "glimmer",
  },
  -- Use a specific prettier parser for a file extension
  ext_parsers = {
    -- qmd = "markdown",
  },
  },
}

require("conform").formatters_by_ft = {
      ["javascript"] = { "prettier" },
      ["javascriptreact"] = { "prettier" },
      ["typescript"] = { "prettier" },
      ["typescriptreact"] = { "prettier" },
      ["vue"] = { "prettier" },
      ["css"] = { "prettier" },
      ["scss"] = { "prettier" },
      ["less"] = { "prettier" },
      ["html"] = { "prettier" },
      ["json"] = { "prettier" },
      ["jsonc"] = { "prettier" },
      ["yaml"] = { "prettier" },
      ["markdown"] = { "prettier" },
      ["markdown.mdx"] = { "prettier" },
      ["graphql"] = { "prettier" },
      ["handlebars"] = { "prettier" },
      ["cpp"] = { "clang_format" },
    }
