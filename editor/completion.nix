{
  "diagnostic.displayByAle" = true;
  languageserver = {
    bash = {
      command = "bash-language-server";
      args = ["start"];
      filetypes = ["sh"];
      ignoredRootPaths = ["~"];
    };
    golang = {
      command = "gopls";
      rootPatterns = ["go.mod" ".git/"];
      filetypes = ["go"];
    };
    nix = {
      command = "rnix-lsp";
      rootPatterns = ["default.nix" ".git"];
      filetypes = ["nix"];
    };
    terraform = {
      command = "terraform-lsp";
      rootPatterns = [".git"];
      filetypes = ["terraform"];
    };
    typescript = {
      command = "tsserver";
      rootPatterns = ["yarn.lock" "package.json" ".git"];
      filetypes = ["js" "ts" "jsx" "tsx"];
    };
  };
}
