return {
  {
    'Civitasv/cmake-tools.nvim',
    opts = {
      cmake_build_directory = "build/${variant:buildType}",
      cmake_soft_link_compile_commands = false,
      cmake_compile_commands_from_lsp = true,
    },
    lazy = true,
  },
}
