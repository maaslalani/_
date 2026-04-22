{
  xdg.configFile."worktrunk/config.toml".text = ''
    skip-shell-integration-prompt = true

    # Strip "maaslalani/" branch prefix from worktree directory names so
    # branches like `maaslalani/foo` live at sibling path `repo.foo`.
    worktree-path = "{{ repo_path }}/../{{ repo }}.{{ branch | replace(\"maaslalani/\", \"\") | sanitize }}"
  '';
}
