with builtins;
let
  files = [
    ./vars.lua
    ./opts.lua
    ./plug.lua
    ./lsp.lua
    ./maps.lua
    ./autocmd.lua
  ];
in
''${concatStringsSep "\n" (map readFile files)}''
