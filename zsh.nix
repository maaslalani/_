let
  DEV_PATH = "/opt/dev/dev.sh";

  sourceFile = file: "[ -f ${file} ] && source ${file}";
in
  {
    enable = true;
    shellAliases = import ./aliases.nix;
    initExtra = ''
      ${sourceFile DEV_PATH}
    '';
    sessionVariables = with builtins; rec {
    };
  }
