return {
  "folke/tokyonight.nvim",
  opts = {
    style = "storm",
    transparent = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
    on_highlights = function(highlights, colors) 
      highlights.FlashLabel = {
        bg = "#ff007c",
        fg = "#19486c",
        bold = false,
      }
    end,
  },
}
