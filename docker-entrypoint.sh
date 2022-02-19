#!/usr/bin/env bash

# AUR Builder script 
# Maintainer: Toni Tauro <eye@eyenx.ch>

AUR_PACKAGES=$*
AUR_BASE=${AUR_BASE:-https://aur.archlinux.org/cgit/aur.git/snapshot}
EXPORT=${EXPORT:-/export}

function log {
  echo "$(date "+%FT%H:%M:%S") | $1 | $2"
}

function main {
  # first sync pacman
  log "INFO" "Populating pacman-keys"
  sudo pacman-key --populate
  log "INFO" "Syncing repositories"
  sudo pacman -Syy &>/dev/null
  # if GPG-KEYS needed, import them
  if [[ -n $ADD_GPG_KEYS ]]
    then 
      gpg --recv-keys $ADD_GPG_KEYS
  fi
  # first check if all given packages exist in AUR
  for PKG in ${AUR_PACKAGES}
    do
      if auracle info ${PKG} >/dev/null
        then log "INFO" "${PKG} exists"
      else
        log "ERROR" "${PKG} does not exists in AUR"
        exit 1
      fi
    # clone all packages and deps
    auracle clone -r $PKG
    auracle buildorder $PKG | grep "^AUR " | awk '{print $2}' | while read line 
      do cd $line && makepkg -si --noconfirm -c && cd .. 
      done
    cd $PKG && makepkg -s --noconfirm -c && rm -rf $PKG*_orig_*tar*
  done
  find /home/aur -iname "*.pkg.tar.*" | while read BUILTPKG
    do 
      log "INFO" "Copying $BUILTPKG into $EXPORT"
      sudo cp -rf $BUILTPKG $EXPORT
    done 
  if [[ -n $REPONAME ]]
  then
    sudo repo-add /export/$REPONAME.db.tar.gz /export/*.pkg.tar.xz
  fi
}

main 
