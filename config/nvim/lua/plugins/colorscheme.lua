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
      highlights.Substitute = {
        bg = "#ff757f",
        fg = "#e6b793"
      }
    end,
  },
}
