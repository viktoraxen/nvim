return {
  cmd = {
    'clangd',
    '--header-insertion=iwyu',
    '--clang-tidy',
    '--log=verbose',
  },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'hpp', 'h' },
  root_markers = { 'build.sh', '.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json', 'compile_flags.txt', 'configure.ac', '.git' },
}
