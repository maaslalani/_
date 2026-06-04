{
  xdg.configFile."worktrunk/config.toml".text = ''
    skip-shell-integration-prompt = true

    # Strip "maaslalani/" branch prefix from worktree directory names so
    # branches like `maaslalani/foo` live at sibling path `repo.worktrees/foo`.
    worktree-path = "{{ repo_path }}/../{{ repo }}.worktrees/{{ branch | replace(\"maaslalani/\", \"\") | sanitize }}"
  '';
}
