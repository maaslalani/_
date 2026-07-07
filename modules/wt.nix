{identity, ...}: {
  programs.worktrunk = {
    enable = true;
    enableZshIntegration = true;
  };

  xdg.configFile."worktrunk/config.toml".text = ''
    skip-shell-integration-prompt = true
    worktree-path = "{{ repo_path }}/../{{ repo }}-{{ branch | replace(\"${identity.githubUser}/\", \"\") | sanitize }}"
  '';
}
