with builtins;
let
  files = [
    ./plug.lua
    ./lsp.lua
    ./maps.lua
    ./autocmd.lua
  ];
in
''${concatStringsSep "\n" (map readFile files)}''
