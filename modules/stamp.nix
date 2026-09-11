{
  identity,
  lib,
  pkgs,
  ...
}: let
  reviewFilter = ''
    [any(.reviews[]; .author.login == "${identity.github}" and .state == "APPROVED"),
      "\(.url | split("/") | .[3:5] | join("/"))#\(.number): \(.title)"] | .[]
  '';
  stamp = pkgs.writeShellScriptBin "stamp" ''
    export GH_PROMPT_DISABLED=1
    CODE=0
    RESULT="$(${pkgs.gh}/bin/gh pr view --json number,title,url,reviews \
      --jq ${lib.escapeShellArg reviewFilter} -- "$@" 2>&1)" || CODE=$?
    if (( CODE == 0 )); then
      APPROVED="''${RESULT%%$'\n'*}"
      PR="''${RESULT#*$'\n'}"
      if [[ "$APPROVED" == true ]]; then
        RESULT="Already approved $PR"
      else
        RESULT="$(${pkgs.gh}/bin/gh pr review --approve --body stamp -- "$@" 2>&1)" && RESULT="Stamped $PR" || CODE=$?
      fi
    fi
    ${pkgs.terminal-notifier}/bin/terminal-notifier -title Stamp -message "$RESULT" || true
    if (( CODE != 0 )); then
      printf '%s\n' "$RESULT" >&2
    fi
    exit "$CODE"
  '';
  service = pkgs.writeShellScript "stamp-service" ''
    reject_input() {
      local message="Select exactly one GitHub pull request URL."
      ${pkgs.terminal-notifier}/bin/terminal-notifier -title Stamp -message "$message" || true
      printf '%s\n' "$message" >&2
      exit 2
    }

    [[ $# == 1 ]] || reject_input
    url=$1
    url="''${url#"''${url%%[![:space:]]*}"}"
    url="''${url%"''${url##*[![:space:]]}"}"
    pattern='^(https://)?github[.]com/([A-Za-z0-9_.-]+)/([A-Za-z0-9_.-]+)/pull/([1-9][0-9]*)([/#?][^[:space:]]*)?$'
    [[ "$url" =~ $pattern ]] || reject_input
    exec ${stamp}/bin/stamp "https://github.com/''${BASH_REMATCH[2]}/''${BASH_REMATCH[3]}/pull/''${BASH_REMATCH[4]}"
  '';
  plist = pkgs.formats.plist {};
  info = plist.generate "stamp-info.plist" {
    NSServices = [
      {
        NSIconName = "NSActionTemplate";
        NSMenuItem.default = "Stamp";
        NSMessage = "runWorkflowAsService";
        NSSendTypes = ["public.utf8-plain-text" "public.url"];
        NSReturnTypes = [];
      }
    ];
  };
  document = plist.generate "stamp-document.wflow" {
    AMApplicationVersion = "2.10";
    AMDocumentVersion = "2";
    actions = [
      {
        action = {
          AMAccepts = {
            Container = "List";
            Optional = true;
            Types = ["com.apple.cocoa.string"];
          };
          AMActionVersion = "2.0.3";
          AMApplication = ["Automator"];
          AMParameterProperties = {
            COMMAND_STRING = {};
            CheckedForUserDefaultShell = {};
            inputMethod = {};
            shell = {};
            source = {};
          };
          AMProvides = {
            Container = "List";
            Types = ["com.apple.cocoa.string"];
          };
          ActionBundlePath = "/System/Library/Automator/Run Shell Script.action";
          ActionName = "Run Shell Script";
          ActionParameters = {
            COMMAND_STRING = ''exec ${service} "$@"'';
            CheckedForUserDefaultShell = true;
            inputMethod = 1;
            shell = "/bin/bash";
            source = "";
          };
          BundleIdentifier = "com.apple.RunShellScript";
          CFBundleVersion = "2.0.3";
          CanShowSelectedItemsWhenRun = false;
          CanShowWhenRun = true;
          Category = ["AMCategoryUtilities"];
          "Class Name" = "RunShellScriptAction";
          InputUUID = "7AF17BC7-0FA4-47EE-8C7F-598DA0EFAFC1";
          OutputUUID = "7AF17BC7-0FA4-47EE-8C7F-598DA0EFAFC2";
          UUID = "7AF17BC7-0FA4-47EE-8C7F-598DA0EFAFC3";
          UnlocalizedApplications = ["Automator"];
          isViewVisible = true;
        };
        isViewVisible = true;
      }
    ];
    connectors = {};
    workflowMetaData = {
      applicationBundleIDsByPath = {};
      applicationPaths = [];
      inputTypeIdentifier = "com.apple.Automator.text";
      outputTypeIdentifier = "com.apple.Automator.nothing";
      presentationMode = 11;
      processesInput = false;
      serviceInputTypeIdentifier = "com.apple.Automator.text";
      serviceOutputTypeIdentifier = "com.apple.Automator.nothing";
      serviceProcessesInput = false;
      systemImageName = "NSActionTemplate";
      useAutomaticInputType = true;
      workflowTypeIdentifier = "com.apple.Automator.servicesMenu";
    };
  };
  workflow = pkgs.runCommand "Stamp.workflow" {} ''
    mkdir -p "$out/Contents"
    cp ${info} "$out/Contents/Info.plist"
    cp ${document} "$out/Contents/document.wflow"
  '';
in {
  home.activation.stampInlineServices = lib.hm.dag.entryAfter ["writeBoundary"] ''
    run /usr/bin/defaults write -g NSServicesMinimumItemCountForContextSubmenu -int 999
  '';

  home.packages = [stamp];
  home.file."Library/Services/Stamp.workflow" = {
    source = workflow;
    onChange = "/System/Library/CoreServices/pbs -update";
  };
}
