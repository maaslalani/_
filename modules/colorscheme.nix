lib: let
  inherit (lib) concatStrings mapAttrsToList;

  rule = name: {
    fg ? "",
    bg ? "",
    gui ? "",
  }:
    if fg == "" && bg == "" && gui == ""
    then ""
    else
      (
        "hi ${name}"
        + (
          if fg == ""
          then ""
          else " guifg=${fg}"
        )
        + (
          if bg == ""
          then ""
          else " guibg=${bg}"
        )
        + (
          if gui == ""
          then ""
          else " gui=${gui}"
        )
        + "\n"
      );

  bold = "bold";
  underline = "underline";
  none = "none";
in
  concatStrings (mapAttrsToList rule {
    ColorColumn.bg = "#202020";
    CursorLine.bg = "#202020";
    CursorLineNr = {
      fg = "#767676";
      bg = "#202020";
    };
    Folded = {
      fg = "#767676";
      bg = "#2a2a2a";
    };
    LineNr.fg = "#505050";
    NonText.fg = "#414141";

    PMenu.bg = "#222222";
    PMenuExtra.bg = "#333333";
    PMenuExtraSel.bg = "#333333";
    PMenuSel.bg = "#333333";
    PMenuSbar.bg = "#222222";
    PMenuThumb.bg = "#292929";

    CmpDocumentation = {
      bg = "#333333";
    };

    SignColumn.bg = none;
    VertSplit = {
      fg = "#262626";
      bg = "#585858";
    };

    Normal.bg = "#171717";
    NormalNC.bg = "#171717";
    NormalFloat.bg = "#222222";

    Boolean = {};
    Comment = {};
    Conditional = {};
    Constant = {gui = bold;};
    Debug = {};
    Define = {};
    Delimiter = {};
    Exception = {};
    Float = {};
    Function = {};
    Identifier = {};
    Include = {};
    Keyword = {};
    Label = {};
    Macro = {};
    Operator = {};
    PreConduit = {};
    PreProc = {};
    Repeat = {};
    Special = {};
    SpecialComment = {};
    Statement = {};
    StorageClass = {};
    String = {};
    Structure = {};
    Tag = {};
    Type = {};
    Typedef = {};

    StatusLine.bg = "#202020";
    StatusLineNC.bg = "#171717";

    Error = {};
    Hint = {};
    Information = {};
    Warning = {};

    DiffDelete = {};
    ErrorMsg = {};

    GitSignsAdd = {};
    GitSignsChange = {};
    GitSignsDelete = {};
  })
