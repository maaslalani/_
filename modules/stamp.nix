{
  identity,
  lib,
  pkgs,
  ...
}: let
  gh = "${pkgs.gh}/bin/gh";
  notify = "${pkgs.terminal-notifier}/bin/terminal-notifier -title Stamp -message";
  reviewFilter = ''
    [any(.latestReviews[]; .author.login == "${identity.github}" and .state == "APPROVED"),
      .id, "\(.url | split("/") | .[3:5] | join("/"))#\(.number): \(.title)"] | .[]
  '';
  approveMutation = ''
    mutation($id: ID!) {
      addPullRequestReview(input: {pullRequestId: $id, event: APPROVE, body: "stamp"}) { clientMutationId }
    }
  '';
  urlHelpers = ''
    reject_input() {
      local message="Select exactly one GitHub pull request or review URL."
      ${notify} "$message" >/dev/null 2>&1 &
      printf '%s\n' "$message" >&2
      exit 2
    }

    normalize_url() {
      local url=$1 pattern
      url="''${url#"''${url%%[![:space:]]*}"}"
      url="''${url%"''${url##*[![:space:]]}"}"
      pattern='^(https://github[.]com|github[.]com|https://[A-Za-z0-9.-]+/review)/([A-Za-z0-9_.-]+)/([A-Za-z0-9_.-]+)/pull/([1-9][0-9]*)([/#?][^[:space:]]*)?$'
      [[ "$url" =~ $pattern ]] || return 1
      printf 'https://github.com/%s/%s/pull/%s\n' "''${BASH_REMATCH[2]}" "''${BASH_REMATCH[3]}" "''${BASH_REMATCH[4]}"
    }
  '';
  stamp = pkgs.writeShellScriptBin "stamp" ''
    ${urlHelpers}
    (( $# <= 1 )) || reject_input
    if (( $# == 1 )); then
      if url="$(normalize_url "$1")"; then
        set -- "$url"
      elif [[ "$1" == *://* || "$1" == github.com/* ]]; then
        reject_input
      fi
    fi
    export GH_PROMPT_DISABLED=1
    CODE=0
    RESULT="$(${gh} pr view --json id,number,title,url,latestReviews \
      --jq ${lib.escapeShellArg reviewFilter} -- "$@" 2>&1)" || CODE=$?
    if (( CODE == 0 )); then
      { read -r APPROVED; read -r ID; read -r PR; } <<< "$RESULT"
      if [[ "$APPROVED" == true ]]; then
        RESULT="Already approved $PR"
      else
        RESULT="$(${gh} api graphql -F id="$ID" -f query=${lib.escapeShellArg approveMutation} 2>&1)" \
          && RESULT="Stamped $PR" || CODE=$?
      fi
    fi
    ${notify} "$RESULT" >/dev/null 2>&1 &
    if (( CODE != 0 )); then
      printf '%s\n' "$RESULT" >&2
    fi
    exit "$CODE"
  '';
  service = pkgs.writeShellScript "stamp-service" ''
    ${urlHelpers}
    [[ $# == 1 ]] || reject_input
    url="$(normalize_url "$1")" || reject_input
    exec ${stamp}/bin/stamp "$url"
  '';
  info = (pkgs.formats.plist {}).generate "stamp-info.plist" {
    CFBundleExecutable = "Stamp";
    CFBundleIdentifier = "com.github.${identity.github}.stamp";
    CFBundleName = "Stamp";
    CFBundlePackageType = "APPL";
    LSBackgroundOnly = true;
    NSServices = [
      {
        NSIconName = "NSActionTemplate";
        NSMenuItem.default = "Stamp";
        NSMessage = "stamp";
        NSPortName = "Stamp";
        NSRequiredContext = {};
        NSSendTypes = ["public.utf8-plain-text" "public.url"];
        NSReturnTypes = [];
      }
    ];
  };
  source = pkgs.writeText "stamp.m" ''
    #import <AppKit/AppKit.h>

    @interface Provider : NSObject
    @end

    @implementation Provider
    - (void)stamp:(NSPasteboard *)pasteboard userData:(NSString *)userData error:(NSString **)error {
      NSString *input = [pasteboard stringForType:NSPasteboardTypeString] ?: [pasteboard stringForType:NSPasteboardTypeURL] ?: @"";
      NSTask *task = [NSTask new];
      task.executableURL = [NSURL fileURLWithPath:[NSBundle.mainBundle pathForAuxiliaryExecutable:@"stamp-service"]];
      task.arguments = @[input];
      [task launchAndReturnError:nil];
      [NSApp performSelector:@selector(terminate:) withObject:nil afterDelay:0];
    }
    @end

    int main(void) {
      @autoreleasepool {
        Provider *provider = [Provider new];
        NSApplication.sharedApplication.servicesProvider = provider;
        [NSApp run];
      }
    }
  '';
  app = pkgs.stdenv.mkDerivation {
    name = "Stamp.app";
    dontUnpack = true;
    buildPhase = ''$CC -O2 -fobjc-arc -framework AppKit ${source} -o Stamp'';
    installPhase = ''
      mkdir -p "$out/Contents/MacOS"
      cp Stamp "$out/Contents/MacOS/Stamp"
      ln -s ${service} "$out/Contents/MacOS/stamp-service"
      cp ${info} "$out/Contents/Info.plist"
    '';
  };
in {
  home.activation.stampInlineServices = lib.hm.dag.entryAfter ["writeBoundary"] ''
    run /usr/bin/defaults write -g NSServicesMinimumItemCountForContextSubmenu -int 999
  '';

  home.packages = [stamp];
  home.file."Library/Services/Stamp.app" = {
    source = app;
    onChange = "/System/Library/CoreServices/pbs -update";
  };
}
