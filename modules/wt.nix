{identity, ...}: {
  xdg.configFile."worktrunk/config.toml".text = ''
    skip-shell-integration-prompt = true

    # Strip "${identity.githubUser}/" branch prefix from worktree directory names so
    # branches like `${identity.githubUser}/foo` live at sibling path `repo.worktrees/foo`.
    worktree-path = "{{ repo_path }}/../{{ repo }}.{{ branch | replace(\"${identity.githubUser}/\", \"\") | sanitize }}"
  '';
}
