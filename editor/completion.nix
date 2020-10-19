{
  "diagnostic.displayByAle" = true;
  languageserver = {
    golang = {
      command = "gopls";
      rootPatterns = [
        "go.mod"
        ".git/"
      ];
      filetypes = ["go"];
    };
  };
}
