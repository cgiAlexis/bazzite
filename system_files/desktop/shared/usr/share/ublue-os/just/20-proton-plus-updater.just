# Reset the Steam folder back to a fresh state
#[group("gaming")]
#fix-reset-steam:
#    #!/usr/bin/bash
#    source /usr/lib/ujust/ujust.sh
#    STEAMPATH="$HOME/.local/share/Steam"
#    # Get a list of the contents of steams top level directory except a list of folders/files we can skip to avoid losing data
#    STEAMFILES=$(ls ~/.local/share/Steam/ | grep -vP "(userdata|compatibilitytools\.d|config|controller_base|steamapps|music)")
#    echo "This script will ${b}remove${n} a bunch of files from $STEAMPATH and sign you out of steam!"
#    echo "However your games, music, saves, controller profiles and compatibilitytools/custom-proton will not be touched."
#    echo "To cancel and abort this operation press CTRL+C now, to continue press ENTER."
#    read i
#    killall -9 steam
#    sleep 1
#    echo "Resetting Steam to a freshly installed state."
#    # Loop through each file and process it
#    for STEAMFILE in $STEAMFILES
#    do
#      if [ -d "$STEAMPATH/$STEAMFILE" ]; then
#        rm -rv "$STEAMPATH/$STEAMFILE"
#      elif [ -f "$STEAMPATH/$STEAMFILE" ]; then
#        rm -v "$STEAMPATH/$STEAMFILE"
#      fi
#    done
#    sleep 1
#    bazzite-steam --disable-firstrun &
#    exit 0

# Toggle systemd-triggered ProtonPlus auto update (https://github.com/Vysp3r/ProtonPlus)
[group("gaming")]
toggle-proton-plus-auto-update
  !/usr/bin/bash
  source /usr/lib/ujust/ujust.sh

  check_pp_update_user() {
    if  [[ -f "/var/home/bazzite/.config/user/proton-plus-auto-update.service" ]]; then
      echo "enabled"
    else
      echo "disabled"
    fi
  }

if [[ "${OPTION,,}" == "status" ]]; then
  check_pp_update_user
  exit 0

# Explain the purpose of the script
echo -e "This script sets the ProtonPlus flatpak to automatically run at startup."
echo -e "It will update all configuration shims that have the 'Latest' qualifier."
echo -e "If you want, edit the created template at `/var/home/bazzite/.config/user/proton-plus-auto-update.service`."

enable_pp_update() [
  
