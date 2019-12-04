if [ -f ~/.nix-profile/etc/profile.d/nix.sh ]; then
  source ~/.nix-profile/etc/profile.d/nix.sh
fi

if [ -f /opt/dev/dev.sh ]; then
  source /opt/dev/dev.sh
fi
